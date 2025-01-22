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
    ignore_install = {
        "zathurarc"
    },
	highlight = {
		enable = true,
		-- disable = { "c", "rust" },
		additional_vim_regex_highlighting = false,
	},
	vim.treesitter.language.register("bash", "zsh"), -- the someft filetype will use the python parser and queries.
})

-- require("conform").setup({
-- 	formatters_by_ft = {
-- 		python = { "ruff_format" },
-- 		bash = { "shellcheck" },
-- 		-- zsh = { "shellcheck" },
-- 		lua = { "stylua" },
-- 		-- css = { "prettier" },
-- 		-- html = { "prettier" },
-- 		-- js = { "prettier" },
-- 		-- go = { "gofumpt" },
-- 		-- latex = { "texlab" },
-- 	},
-- 	format_after_save = {
-- 		timeout_ms = 500,
-- 		lsp_fallback = true,
-- 	},
-- 	["*"] = { "codespell" },
-- 	-- Use the "_" filetype to run formatters on filetypes that don't
-- 	-- have other formatters configured.
-- 	["_"] = { "trim_whitespace" },
-- 	log_level = vim.log.levels.ERROR,
-- 	notify_on_error = true,
-- })
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*",
-- 	callback = function(args)
-- 		require("conform").format({ bufnr = args.buf })
-- 	end,
-- })
-- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

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

-- require("nvim-surround").setup()
require("mini.surround").setup({
    mappings = {
        add = 'ta',
        delete = 'td', -- Delete surrounding
        find = 'tf', -- Find surrounding (to the right)
        find_left = 'tF', -- Find surrounding (to the left)
        highlight = 'th', -- Highlight surrounding
        replace = 'tr', -- Replace surrounding
        update_n_lines = 'tn', -- Update `n_lines
    }
})

-- require("nvim-dap-virtual-text").setup()

require("nvim-autopairs").setup({
	check_ts = true,
	ts_config = {
		lua = { "string" }, -- it will not add a pair on that treesitter node
		javascript = { "template_string" },
	},
	enable_check_bracket_line = false,
	ignored_next_char = "[%w%.]",
})

require("colorizer").setup({
	'css' ;
	'javascript' ;
}, { mode = 'foreground' })


