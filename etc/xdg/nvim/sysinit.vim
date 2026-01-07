" This line makes pacman-installed global Arch Linux vim packages work.
"source /usr/share/nvim/archlinux.lua
"
" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.

" disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
"if &term =~ '256color'
"	set t_ut=
"endif

colorscheme dracula

if $TERM == 'linux'
    colorscheme dracula
elseif $TERM == 'foot'
	set termguicolors
endif

syntax on
filetype plugin on
set path+=**

let mapleader=","
autocmd InsertEnter * call chansend(v:stderr, "\033[?737769h")
autocmd InsertLeave * call chansend(v:stderr, "\033[?737769l")

lua <<EOF

vim.opt.ttimeoutlen = 0
-- vim.opt.termguicolors = true
-- vim.opt.autocomplete = true
vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.backspace = "indent,eol,start"
-- vim.opt.cindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.confirm = true
vim.opt.completeopt = "menuone,popup,noselect,fuzzy"
vim.wo.cursorline = true
vim.opt.foldlevelstart = 2
vim.opt.foldmethod = expr
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
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
vim.opt.signcolumn = "auto"
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.errorbells = false
-- vim.o.showbreak = "\u{21AA} "
-- vim.o.showbreak = "↪ \\ "
vim.o.showbreak = "&"
vim.opt.showmode = false
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.bo.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wildmenu = true
vim.opt.wildmode = "lastused,full"
vim.opt.pumheight = 10
vim.opt.showmatch = true
vim.opt.showcmd = false
vim.opt.showtabline = 2
vim.opt.smartcase = true
-- vim.opt.statuscolumn = "%l%s"
vim.opt.wrap = true
-- vim.opt.winborder = 'rounded'
-- vim.opt.ttyfast = true


EOF

" Uncomment the next line to use Vim as the editor for new files by default
" let &editor = 'nvim'

"set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,latin1
"set ignorecase
"set list
"set listchars=tab:*~
"set smartcase
"set smartindent
"set spell spelllang=en_us
"set timeoutlen=300
"set updatetime=200
"set wrapmargin=20

"change cursor shape
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[3 q"
let &t_EI = "\<esc>[ q"

let g:netrw_keepdir = 0
let g:netrw_winsize = 30
let g:netrw_banner = 0
let g:netrw_browser_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3

"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
"let g:netrw_localcopydircmd = 'cp -r'

hi! link netrwMarkFile Search
"hi	FloatBorder	cterm=NONE	ctermfg=11	ctermbg=15	guifg=NONE	guibg=NONE	gui=NONE

"autocmd BufRead,BufNewFile *.network,*.dae,*.rules, setlocal filetype=ini
"autocmd BufRead,BufNewFile *.conf,*.network,*.dae,*.rules setlocal filetype=ini
autocmd BufRead,BufNewFile *.wbt setlocal filetype=wrl

"function Gitbranch()
"    return trim(system("git -C " . expand("%:h") . " branch --show-current 2>/dev/null"))
"endfunction
"augroup Gitget
"    autocmd!
"    autocmd BufEnter * let b:git_branch = Gitbranch()
"augroup END

set statusline+=%0*\ %n\                                 " Buffer number
set statusline+=%0*\ %{toupper(mode())}				 " The current mode
set statusline+=%0*\ %y                                " FileType
set statusline+=%0*\ %{''.(&fenc!=''?&fenc:&enc).''}     " Encoding
set statusline+=\ (%{&ff})                               " FileFormat (dos/unix..)
set statusline+=%0*\ %<%f%m%r%h%w                       " File path, modified, readonly, helpfile, preview
"set statusline+=%0*\ %{b:git_branch}
set statusline+=%=                                       " Right Side
set statusline+=%0*\ L:\%02l\ C:\%02v\ (%p%%)\          " Colomn number, Line number / total lines, percentage of document
