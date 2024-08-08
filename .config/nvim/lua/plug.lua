#!/usr/bin/lua
-- require"nvim-treesitter.install".update{ with_sync = true }
-- require("nvim-treesitter.install").prefer_git = true

require("nvim-treesitter.configs").setup({
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn", -- set to `false` to disable one of the mappings
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	indent = { enable = true },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		-- disable = { "c", "rust" },
		additional_vim_regex_highlighting = false,
	},
	vim.treesitter.language.register("bash", "zsh"), -- the someft filetype will use the python parser and queries.
})

require("conform").setup({
	formatters_by_ft = {
		python = { "ruff_format" },
		bash = { "shellcheck" },
		-- zsh = { "shellcheck" },
		lua = { "stylua" },
		-- css = { "prettier" },
		-- html = { "prettier" },
		-- js = { "prettier" },
		-- go = { "gofumpt" },
		-- latex = { "texlab" },
	},
	format_after_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	["*"] = { "codespell" },
	-- Use the "_" filetype to run formatters on filetypes that don't
	-- have other formatters configured.
	["_"] = { "trim_whitespace" },
	log_level = vim.log.levels.ERROR,
	notify_on_error = true,
})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

require("hlsearch").setup()

local set_hl_for_floating_window = function()
	vim.api.nvim_set_hl(0, "NormalFloat", {
		link = "Normal",
	})
	vim.api.nvim_set_hl(0, "FloatBorder", {
		bg = "none",
	})
end
set_hl_for_floating_window()

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	-- desc = 'Avoid overwritten by loading color schemes later',
	callback = set_hl_for_floating_window,
})

require("nvim-dap-virtual-text").setup()
