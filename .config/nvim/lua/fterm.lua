-- fterm.nvim https://github.com/jiajiawang/fterm.nvim

local state = {
	fterm_win = nil,
	fterm_buf = nil,
	parent_win = nil,
	-- parent_mode = nil,
}

local function CreateFloaTerm()
	state.fterm_buf = vim.api.nvim_create_buf(false, true)

	local width = math.floor(vim.o.columns * 0.6)
	local height = vim.o.lines - 5
	local row = 1
	local col = vim.o.columns - width

	state.fterm_win = vim.api.nvim_open_win(state.fterm_buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})
	vim.cmd.terminal()
	vim.cmd("startinsert")
end

local togglefloaterm = function()
	if not state.fterm_buf then
		state.parent_win = vim.api.nvim_get_current_win()
		-- state.parent_mode = vim.api.nvim_get_mode().mode
		CreateFloaTerm()
	elseif vim.api.nvim_win_get_config(state.fterm_win).hide then
		vim.api.nvim_win_set_config(state.fterm_win, { hide = false })
		vim.api.nvim_set_current_win(state.fterm_win)
		vim.cmd("startinsert")
	else
		vim.api.nvim_win_set_config(state.fterm_win, { hide = true })
		vim.api.nvim_set_current_win(state.parent_win)
	end
end

vim.keymap.set({ "n", "i", "t" }, "<M-S-t>", togglefloaterm, { noremap = true })
