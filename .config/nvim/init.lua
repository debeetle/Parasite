#!/usr/bin/lua
-- vim.g.do_filetype_lua = 1
-- vim.g.did_load_filetypes = 0
vim.opt.titlestring = "%t"

local map = vim.api.nvim_set_keymap
map("i", "<C-V>", "<Esc>l'+Pli'", { noremap = true })
map("n", "<C-S-e>", "<Cmd>Lexplore<CR>", { silent = true, noremap = true })
map("c", "UP", "PaqUpdate<CR>", { noremap = true })
map("i", "<C-a>", "<C-o>0", { silent = true, noremap = true })
map("i", "<C-e>", "<C-o>A", { silent = true, noremap = true })
map("i", "<M-h>", "<left>", { silent = true, noremap = true })
map("i", "<M-j>", "<down>", { silent = true, noremap = true })
map("i", "<M-k>", "<up>", { silent = true, noremap = true })
map("i", "<M-l>", "<right>", { silent = true, noremap = true })

require("paq")({
	{ "savq/paq-nvim" },
	{ "nvimdev/hlsearch.nvim" },
	{ "nvimdev/guard.nvim", opt = false },

	{ "nvim-mini/mini.surround" },
	{ "nvim-mini/mini.indentscope" },
	{ "nvim-mini/mini.pairs" },
	{ "nvim-mini/mini.icons" },
	{ "nvim-mini/mini.diff", opt = true },
	{ "nvim-mini/mini.completion" },
	{ "nvim-mini/mini.snippets" },
	{ "nvim-mini/mini.hipatterns", opt = true },
	{ "nvim-mini/mini.align", opt = true },
	-- { "nvim-mini/mini.animate" },

	{ "neovim/nvim-lspconfig" },
	{ "rafamadriz/friendly-snippets" },
	-- { "stevearc/conform.nvim", opt = true },

	{ "chomosuke/typst-preview.nvim", opt = true },

	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "nvim-treesitter/nvim-treesitter-refactor" },
	-- { "nvim-treesitter/nvim-treesitter-context", opt = true},

	{ "mfussenegger/nvim-dap" },
	{ "theHamsta/nvim-dap-virtual-text" },
	-- { "folke/twilight.nvim"},
	-- { "JoosepAlviste/nvim-ts-context-commentstring" },
})

require("fterm")
require("pluginsetup")
require("minicmp")
require("lintformat")

vim.diagnostic.config({
	signs = false, --去除行号左边的error标识
	virtual_text = true,
	underline = false,
	virtual_line = { current_line = true },
	float = {
		focusable = true,
	},
})

vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = { "*.html", "*.typ" },
	callback = function(args)
		local ext = vim.bo[args.buf].filetype
		local tmpl = "/home/chaos/.config/nvim/templates/" .. ext .. ".tpl"
		local f = io.open(tmpl, "r")
		if not f then
			return
		end
		local content = f:read("*a")
		f:close()
		vim.snippet.expand(content)
	end,
})

-- -- 将 cmp 初始化移动到 autocmd 延迟加载
-- vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
-- 	callback = function()
-- 		require("fterm")
-- 	end,
-- })
--
