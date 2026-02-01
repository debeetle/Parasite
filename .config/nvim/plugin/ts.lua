-- require("nvim-treesitter.install").prefer_git = true

-- require 'nvim-treesitter'.install { 'python', 'bash' }
require 'nvim-treesitter'.setup({
	-- incremental_selection = {
	-- 	enable = true,
	-- 	keymaps = {
	-- 		init_selection = "gnn", -- set to `false` to disable one of the mappings
	-- 		node_incremental = false,
	-- 		scope_incremental = false,
	-- 		node_decremental = false,
	-- 		-- node_incremental = "grn",
	-- 		-- scope_incremental = "grc",
	-- 		-- node_decremental = "grm",
	-- 	},
	-- },
	-- indent = { enable = true },
	-- sync_install = true,
	auto_install = false,
	ignore_install = {
		"c",
		"lua",
		"vim",
		"query",
		"diff",
		"vimdoc",
		"markdown",
		"fish",
		"bash",
		"zsh",
		"make",
		"passwd",
		-- "ini",
		-- "html",
	},
	-- highlight = {
	-- 	enable = true,
	-- disable = { "c", "rust", "html" },
	-- 	additional_vim_regex_highlighting = true,
	-- },

	-- refactor = {
	-- 	highlight_definitions = {
	-- 		enable = true,
	-- 		clear_on_cursor_move = true,
	-- 	},
	-- 	highlight_current_scope = {
	-- 		enable = true,
	-- 	},
	-- 	smart_rename = {
	-- 		enable = true,
	-- 		-- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
	-- 		keymaps = {
	-- 			smart_rename = "grr",
	-- 		},
	-- 	},
	-- },

	-- vim.treesitter.language.register("bash", { "sh" }), -- the someft filetype will use the python parser and queries.
})
-- vim.treesitter.language.register("bash", { "sh" })   -- the someft filetype will use the python parser and queries.
-- vim.treesitter.language.register("zsh", { "sh" })   -- the someft filetype will use the python parser and queries.

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'lua', 'c', 'cpp', 'css', 'fish', 'go', 'html', 'javascript', 'json', 'python', 'sh', 'typescript', 'typst' },
	callback = function()
		-- vim.treesitter.start()
		-- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		-- vim.wo[0][0].foldmethod = 'expr'
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- configuration
require("nvim-treesitter-textobjects").setup {
	select = {
		-- Automatically jump forward to textobj, similar to targets.vim
		lookahead = true,
		-- You can choose the select mode (default is charwise 'v')
		--
		-- Can also be a function which gets passed a table with the keys
		-- * query_string: eg '@function.inner'
		-- * method: eg 'v' or 'o'
		-- and should return the mode ('v', 'V', or '<c-v>') or a table
		-- mapping query_strings to modes.
		selection_modes = {
			['@parameter.outer'] = 'v', -- charwise
			['@function.outer'] = 'V', -- linewise
			['@class.outer'] = '<c-v>', -- blockwise
		},
		-- If you set this to `true` (default is `false`) then any textobject is
		-- extended to include preceding or succeeding whitespace. Succeeding
		-- whitespace has priority in order to act similarly to eg the built-in
		-- `ap`.
		--
		-- Can also be a function which gets passed a table with the keys
		-- * query_string: eg '@function.inner'
		-- * selection_mode: eg 'v'
		-- and should return true of false
		include_surrounding_whitespace = false,
	},
}

-- keymaps
-- You can use the capture groups defined in `textobjects.scm`
vim.keymap.set({ "x", "o" }, "am", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "im", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
end)
-- You can also use captures from other query groups like `locals.scm`
vim.keymap.set({ "x", "o" }, "as", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
end)
