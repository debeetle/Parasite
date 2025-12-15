vim.opt.termguicolors = true

vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.backspace = "indent"
vim.opt.cindent = true
vim.opt.confirm = true
vim.wo.cursorline = true
vim.opt.foldlevelstart = 2
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.laststatus = 2
vim.opt.linebreak = true
vim.opt.lazyredraw = true
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.wo.signcolumn = "auto"
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.errorbells = false
vim.opt.showmode = false
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
-- vim.bo.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wildmenu = true
vim.opt.wildmode = "full"
vim.opt.pumheight = 10
vim.opt.showmatch = true
vim.opt.showcmd = true
vim.opt.showtabline = 2
vim.opt.smartcase = true
vim.opt.wrap = true
vim.opt.ttyfast = true

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.patch",
  command = "setlocal filetype=diff",          -- 直接使用 command 参数更高效
  group = vim.api.nvim_create_augroup("PatchFileType", { clear = true })  -- 创建独立组
})

vim.keymap.set('i', 'jk', '<Esc>', {
  noremap = true,  -- 禁用递归映射
  silent = true,   -- 静默执行
})
