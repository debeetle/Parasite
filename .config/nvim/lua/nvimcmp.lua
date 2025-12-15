-- Set up nvim-cmp.
-- local has_words_before = function()
-- 	unpack = unpack or table.unpack
-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

-- local luasnip = require("luasnip")
-- require("luasnip.loaders.from_vscode").lazy_load()
-- luasnip.filetype_extend("typescript", { "tsdoc" })
-- luasnip.filetype_extend("javascript", { "jsdoc" })
-- luasnip.filetype_extend("lua", { "luadoc" })
-- luasnip.filetype_extend("python", { "pydoc" })
-- luasnip.filetype_extend("rust", { "rustdoc" })
-- luasnip.filetype_extend("c", { "cdoc" })
-- luasnip.filetype_extend("cpp", { "cppdoc" })
-- luasnip.filetype_extend("sh", { "shelldoc" })

vim.o.completeopt = "menuone,noinsert,popup,fuzzy"
local cmp = require("cmp")

local mini_snippets = require("mini.snippets")
mini_snippets.start_lsp_server()
local match_strict = function(snips)
	-- Do not match with whitespace to cursor's left
	return mini_snippets.default_match(snips, { pattern_fuzzy = "%S+" })
end
mini_snippets.setup({
	snippets = {
		-- mini_snippets.gen_loader.from_file("~/.config/nvim/snippets/global.json"),
		mini_snippets.gen_loader.from_lang(),
	},
	mappings = { expand = "<CR>", jump_next = "<C-S-j>", jump_prev = "<C-S-k>" },
	expand = { match = match_strict },
})

-- _G.cr_action = function()
-- 	if vim.fn.pumvisible() ~= 0 then
-- 		-- If popup is visible, confirm selected item or add new line otherwise
-- 		local item_selected = vim.fn.complete_info()["selected"] ~= -1
-- 		return item_selected and keys["ctrl-y"] or keys["ctrl-y_cr"]
-- 	else
-- 		-- If popup is not visible, use plain `<CR>`. You might want to customize
-- 		-- according to other plugins. For example, to use 'mini.pairs', replace
-- 		-- next line with `return require('mini.pairs').cr()`
-- 		return keys["cr"]
-- 	end
-- end

-- vim.keymap.set("i", "<CR>", "v:lua._G.cr_action()", { expr = true })

local imap_expr = function(lhs, rhs)
	vim.keymap.set("i", lhs, rhs, { expr = true })
end
imap_expr("<CR>", [[pumvisible() ? "\<C-y>" : "\<CR>"]])

local function jumpnext_snippet(fallback)
	if cmp.visible() then
		cmp.select_next_item()
	-- elseif MiniSnippets.expand({ insert = false }) then
	--   MiniSnippets.expand()  -- Expand the snippet
	elseif MiniSnippets.session.get() then
		MiniSnippets.session.jump("next") -- Jump to the next tabstop
	else
		fallback()
	end
end

local function jumpback_snippet(fallback)
	if cmp.visible() then
		cmp.select_prev_item()
	elseif MiniSnippets.session.get() then
		MiniSnippets.session.jump("prev") -- Jump to the previous tabstop
	else
		fallback()
	end
end

local function expand_confirm(fallback)
	if cmp.visible() and cmp.get_active_entry() then
		if #MiniSnippets.expand({ insert = false }) > 0 then
			MiniSnippets.expand() -- Expand the snippet
		else
			cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
		end
	else
		fallback()
	end
end

cmp.setup({
	snippet = {
		expand = function(args)
			-- luasnip.lsp_expand(args.body)
			local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
			insert({ body = args.body }) -- Insert at cursor
			cmp.resubscribe({ "TextChangedI", "TextChangedP" })
			-- require("cmp.config").set_onetime({ sources = {} })
		end,
	},
	--
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
		completion = {
			-- 设置 winhighlight 为将 FloatBorder 颜色映射到 Pmenu 颜色
			winhighlight = "FloatBorder:Pmenu,Normal:Pmenu,CursorLine:PmenuSel,Search:None",
			border = "rounded",
		},
		documentation = {
			-- winhighlight = "FloatBorder:NormalFloat,Normal:NormalFloat",
			winhighlight = "FloatBorder:Pmenu,Normal:Pmenu,CursorLine:PmenuSel,Search:None",
			border = "rounded",
		},
	},

	view = {
		entries = { name = "custom" },
	},

	formatting = {
		format = require("lspkind").cmp_format({
			mode = "symbol_text",
			maxwidth = function()
				return math.floor(0.45 * vim.o.columns)
			end,
			ellipsis_char = "...",
			show_labelDetails = true,
			menu = {
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				-- luasnip = "[LuaSnip]",
				mini_snippets = "[Snippet]",
				treesitter = "[Tree]",
				path = "[Path]",
			},
		}),
	},

	mapping = {
		["<C-j>"] = cmp.mapping(jumpnext_snippet, { "i", "s", "c" }),
		["<C-k>"] = cmp.mapping(jumpback_snippet, { "i", "s", "c" }),
		["<CR>"] = cmp.mapping({
			i = expand_confirm,
			s = cmp.mapping.confirm({ select = true }),
			c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
		}),
	},

	-- -- LUASNIP MAPPING
	-- mapping = cmp.mapping.preset.insert({
	-- 	["<C-j>"] = cmp.mapping(function(fallback)
	-- 		if cmp.visible() then
	-- 			cmp.select_next_item()
	-- 		elseif luasnip.locally_jumpable(1) then
	-- 			luasnip.jump(1)
	-- 		else
	-- 			fallback()
	-- 		end
	-- 	end, {
	-- 		"i",
	-- 		"s",
	-- 		"c", --[[ "c" (to enable the mapping in command mode) ]]
	-- 	}),
	-- 	["<C-k>"] = cmp.mapping(function(fallback)
	-- 		if cmp.visible() then
	-- 			cmp.select_prev_item()
	-- 		elseif luasnip.locally_jumpable(-1) then
	-- 			luasnip.jump(-1)
	-- 		else
	-- 			fallback()
	-- 		end
	-- 	end, {
	-- 		"i",
	-- 		"s",
	-- 		"c", --[[ "c" (to enable the mapping in command mode) ]]
	-- 	}),
	-- 	["<Tab>"] = cmp.mapping({
	-- 		i = function(fallback)
	-- 			if cmp.visible() and cmp.get_active_entry() then
	-- 				if luasnip.expandable() then
	-- 					luasnip.expand()
	-- 				else
	-- 					-- cmp.confirm({select = true,})
	-- 					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
	-- 				end
	-- 			else
	-- 				fallback()
	-- 			end
	-- 		end,
	-- 		s = cmp.mapping.confirm({ select = true }),
	-- 		c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
	-- 		-- c = function(fallback)
	-- 		-- 	if cmp.visible() then
	-- 		-- 		cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
	-- 		--        else
	-- 		-- 		fallback()
	-- 		--        end
	-- 		--    end
	-- 	}),
	-- }),
	-- -- LUASNIP MAPPING

	sources = cmp.config.sources({
		{ name = "mini_snippets" },
		-- { name = "luasnip", option = { show_autosnippets = true } },
		-- { name = "nvim_lsp" },
		{ name = "path" },
		-- { name = "omni", option = { disable_omnifuncs = { "v:lua.vim.lsp.omnifunc" } } },
	}, {
		{ name = "buffer" },
		{ name = "treesitter" },
		-- { name = "css-variables", option = { show_autosnippets = true } },
		-- { name = "nvim_lsp_signature_help", option = { show_autosnippets = true } },
	}),
})
