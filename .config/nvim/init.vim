let g:omni_sql_default_compl_type = 'syntax'

inoremap <silent> <C-V> <Esc>l"+Pli"
nnoremap <silent> <M-f> :lua require('fterm').toggle()<CR>
nnoremap <silent> <C-e> :Lexplore<CR>
nnoremap <silent> <C-n> :bnext<CR>
nnoremap <silent> <C-p> :bprev<CR>
cnoremap UP PaqUpdate<CR>
cnoremap <silent> CV :set norelativenumber<CR> :set nonumber<CR>

" LEXIMA
let g:lexima_enable_basic_rules = 1
let g:lexima_enable_newline_rules = 1
let g:lexima_enable_endwise_rules = 1

" " HEXOKINASE
let g:Hexokinase_highlighters = [ 'backgroundfull' ]

lua <<EOF
vim.opt.titlestring = "%t"

local map = vim.api.nvim_set_keymap
--map("i", "<C-f>", "<CMD>lua require('FTerm').toggle()<CR>", { silent = true, noremap = true, nowait = true })
map("t", "<M-f>", "<C-\\><C-n><CMD>lua require('fterm').toggle()<CR>", { silent = true, noremap = true, nowait = true })
-- map('n', '<esc>', ':nohlsearch<cr>', { noremap = true, silent = true })

require "paq"{
	{"savq/paq-nvim"},
--	{"numToStr/FTerm.nvim"},
	{"nvimdev/hlsearch.nvim"},
	{ "cohama/lexima.vim" },
	{"rrethy/vim-hexokinase", opt=true},
	{"neovim/nvim-lspconfig"},
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-omni" },
	{ "hrsh7th/cmp-path" },
	-- { "hrsh7th/cmp-cmdline"},
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	-- { "Sirver/ultisnips"},
	-- { "quangnguyen30192/cmp-nvim-ultisnips" },
    { "L3MON4D3/LuaSnip"},
    { "rafamadriz/friendly-snippets" },
    { "saadparwaiz1/cmp_luasnip"},
    { "ray-x/cmp-treesitter"},
    -- {"roginfarrer/cmp-css-variables", opt=true},
	{ "onsails/lspkind.nvim" },
	-- { "yehuohan/cmp-im" },
	{ "stevearc/conform.nvim" },
	-- {
	{ "nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{ "mfussenegger/nvim-dap"},
	{ "theHamsta/nvim-dap-virtual-text"},
	-- {"folke/twilight.nvim"},
	{ "JoosepAlviste/nvim-ts-context-commentstring"},
	{ "nvim-treesitter/nvim-treesitter-context"},
	-- {
	-- "chomosuke/typst-preview.nvim",
	-- build = function() require 'typst-preview'.update() end,
	-- },
}

require('plug')
require('autocmp')

-- vim.keymap.set("n","<C-V>",'"+y')
EOF
