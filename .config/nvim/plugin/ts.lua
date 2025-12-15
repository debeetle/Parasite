-- vim.cmd([[packadd nvim-treesitter]])

-- require("nvim-treesitter.install").update({ with_sync = true })
-- require("nvim-treesitter.install").prefer_git = true

require("nvim-treesitter.configs").setup({
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn", -- set to `false` to disable one of the mappings
			node_incremental = false,
			scope_incremental = false,
			node_decremental = false,
			-- node_incremental = "grn",
			-- scope_incremental = "grc",
			-- node_decremental = "grm",
		},
	},
	indent = { enable = true },
	sync_install = false,
	auto_install = true,
	ignore_install = {
		"c",
		"diff",
		"fish",
		"lua",
		"vim",
		"vimdoc",
		"markdown",
		"make",
		"query",
		-- "html",
		"ini",
		"passwd",
	},
	highlight = {
		enable = true,
		-- disable = { "c", "rust", "html" },
		additional_vim_regex_highlighting = true,
	},

	refactor = {
		highlight_definitions = {
			enable = true,
			clear_on_cursor_move = true,
		},
		highlight_current_scope = {
			enable = true,
		},
		smart_rename = {
			enable = true,
			-- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
			keymaps = {
				smart_rename = "grr",
			},
		},
	},

	vim.treesitter.language.register("bash", "zsh"), -- the someft filetype will use the python parser and queries.
})
