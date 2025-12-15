local M = {}

local function tolines(items, opts)
	local func = nil
	if opts["key"] ~= nil then
		local key = opts["key"]
		func = function(item)
			return item[key]
		end
	elseif opts["text_cb"] ~= nil then
		func = opts["text_cb"]
	end
	if func ~= nil then
		return vim.tbl_map(func, items)
	end
	return items
end

function M.pick(prompt, src, onclose, opts)
	opts = vim.tbl_deep_extend("force", { matchseq = 1 }, opts or {})
	if type(src) == "function" then
		src(function(items)
			M.pick(prompt, items, onclose, opts)
		end)
		return
	end
	local items = src
	local sitems = nil
	-- if #items == 0 then
	-- 	vim.api.nvim_echo({ { "No " .. prompt .. " to select", "WarningMsg" } }, false, {})
	-- 	onclose(nil)
	-- 	return
	-- elseif #items == 1 then
	-- 	onclose(items[1])
	-- 	return
	-- end
	local pbuf = vim.api.nvim_create_buf(false, true)
	vim.b[pbuf].completion = false
	local width = math.min(70, vim.o.columns - 10)
	local height = 11
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)
	vim.api.nvim_open_win(pbuf, true, {
		relative = "editor",
		width = width,
		height = 1,
		row = row,
		col = col,
		style = "minimal",
		border = nil,
	})

	local ns = vim.api.nvim_create_namespace("fuzzyhl")

	local sbuf = vim.api.nvim_create_buf(false, true)
	local function create_select_win()
		local swin = vim.api.nvim_open_win(sbuf, false, {
			relative = "editor",
			width = width,
			height = height - 2,
			row = row + 2,
			col = col,
			style = "minimal",
			border = "rounded",
			focusable = false,
		})
		vim.api.nvim_set_option_value("cursorline", true, { win = swin })
		return swin
	end
	local swin = create_select_win()
	vim.cmd.startinsert()
	local function close(confirm)
		local item = nil
		if confirm then
			local line = vim.fn.line(".", swin)
			if sitems ~= nil and line > 0 and line <= #sitems then
				item = sitems[line]
			end
		end
		vim.cmd.stopinsert()
		vim.api.nvim_buf_delete(pbuf, {})
		vim.api.nvim_buf_delete(sbuf, {})
		onclose(item)
	end
	local function move(i)
		local line = vim.api.nvim_win_get_cursor(swin)[1]
		line = line + i
		if line > 0 and line <= vim.api.nvim_buf_line_count(sbuf) then
			vim.api.nvim_win_set_cursor(swin, { line, 0 })
		end
	end
	vim.keymap.set("i", "<cr>", function()
		close(true)
	end, { buffer = pbuf })
	vim.keymap.set("i", "<esc>", function()
		close(false)
	end, { buffer = pbuf })
	vim.keymap.set("i", "<c-j>", function()
		move(1)
	end, { buffer = pbuf })
	vim.keymap.set("i", "<c-k>", function()
		move(-1)
	end, { buffer = pbuf })
	local function setitems(lines, pos)
		sitems = lines
		lines = tolines(lines, opts)
		vim.api.nvim_buf_clear_namespace(sbuf, ns, 0, -1)
		vim.api.nvim_buf_set_lines(sbuf, 0, -1, false, lines)
		if #lines == 0 then
			if swin ~= -1 then
				vim.api.nvim_win_hide(swin)
				swin = -1
			end
		else
			if swin == -1 then
				swin = create_select_win()
			end
			vim.api.nvim_win_set_height(swin, math.min(height - 2, #lines))
			local w = width
			for _, line in ipairs(lines) do
				w = math.max(w, #line)
			end
			vim.api.nvim_win_set_width(swin, w)
			if pos ~= nil then
				for line, arr in ipairs(pos) do
					for _, p in ipairs(arr) do
						vim.api.nvim_buf_set_extmark(sbuf, ns, line - 1, p, {
							end_col = p + 1,
							hl_group = "Special",
							strict = false,
						})
					end
				end
			end
		end
	end
	setitems(items)
	vim.api.nvim_create_autocmd("TextChangedI", {
		buffer = pbuf,
		callback = function()
			local query = vim.fn.getline(1)
			if #query > 0 then
				local matched = vim.fn.matchfuzzypos(items, query, opts)
				setitems(matched[1], matched[2])
			else
				setitems(items, nil)
			end
		end,
	})
end

function M.select(items, opts, on_choice)
	local prompt = opts and opts["prompt"] or ""
	prompt = prompt:match("^%s*(.-)%s*$") or ""
	if #prompt > 1 and prompt:sub(-1) == ":" then
		prompt = prompt:sub(1, -2)
	end
	local popts = {}
	if opts and opts["format_item"] ~= nil then
		popts["text_cb"] = opts["format_item"]
	end
	M.pick(prompt, items, on_choice, popts)
end

------------------------------------------------------------------------

local function files()
	local cmd
	if vim.fn.executable("fd") == 1 then
		cmd = "fd --type f --type l --color=never -E .git"
	elseif vim.fn.executable("rg") == 1 then
		cmd = "rg --files --no-messages --color=never"
	else
		cmd = "find . -type f -not -path '*/git/*'"
	end
	return vim.fn.systemlist(cmd)
end

local function edit(item)
	if item then
		vim.cmd.edit(item)
	end
end

function M.pick_file()
	M.pick("File", files(), edit)
end

------------------------------------------------------------------------

local function buffers()
	local cur = vim.fn.bufnr("%")
	local alt = vim.fn.bufnr("#")
	local items = {}
	for _, bufinfo in ipairs(vim.fn.getbufinfo({ bufloaded = 1, buflisted = 1 })) do
		if bufinfo.bufnr == alt then
			table.insert(items, 1, vim.fn.fnamemodify(bufinfo.name, ":."))
		elseif bufinfo.bufnr ~= cur then
			table.insert(items, vim.fn.fnamemodify(bufinfo.name, ":."))
		end
	end
	return items
end

function M.pick_buffer()
	M.pick("Buffer", buffers(), edit)
end

------------------------------------------------------------------------

function M.setup()
	vim.ui.select = M.select
	vim.keymap.set("n", "<leader>f", M.pick_file)
	vim.keymap.set("n", "<leader>b", M.pick_buffer)
end

return M
