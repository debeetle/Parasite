" This line makes pacman-installed global Arch Linux vim packages work.
" source /usr/share/nvim/archlinux.vim
"
" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.

if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
	set t_ut=
endif
" if $TERM == 'xterm-256color' || $TERM == 'st-256color' || $TERM == 'foot'
set termguicolors 
colorscheme dracula
" endif

" Uncomment the next line to use Vim as the editor for new files by default
" let &editor = 'nvim'

set autoindent
set autoread
set backspace=indent,eol,start
set cindent
"set clipboard=unnamedplus
set confirm
set cursorline
set encoding=utf-8
set expandtab
filetype plugin indent on
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,latin1
set foldlevelstart=2
set hlsearch
set inccommand=split
"set ignorecase
set incsearch
set laststatus=2
" set linebreak
" set list
" set listchars=tab:*~
set lazyredraw
set mouse=
set nocompatible
set nobackup
set noerrorbells
set noswapfile
set nowritebackup
set number
set path+=**
set pumheight=10
set relativenumber
set ruler
set signcolumn=auto
set shiftwidth=4
set showmatch
set showmode
set showcmd
set showtabline=2
set smartcase
set smartindent
syntax off
set softtabstop=4
set splitbelow
set splitright
" set spell spelllang=en_us
set tabstop=4
set termencoding=utf-8
set t_Co=256
set ttyfast
set timeoutlen=300
set updatetime=200
set wildmenu
set wildmode=longest:list,full
set nowrap
set wrapmargin=2
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable                     " Disable folding at startup.

inoremap jk <esc>
"change cursor shape
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[3 q"
let &t_EI = "\<esc>[ q"
"let mapleader = ","

let g:netrw_keepdir = 0
let g:netrw_winsize = 30
let g:netrw_banner = 0
let g:netrw_browser_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
let g:netrw_localcopydircmd = 'cp -r'

hi! link netrwMarkFile Search
hi	FloatBorder	cterm=NONE	ctermfg=11	ctermbg=15	guifg=NONE	guibg=NONE	gui=NONE

autocmd BufRead,BufNewFile *.conf setlocal filetype=ini

set noshowmode
set statusline+=%0*\ %n\                                 " Buffer number
set statusline+=%0*\ %{toupper(mode())}				 " The current mode
set statusline+=%0*\ %<%F%m%r%h%w                       " File path, modified, readonly, helpfile, preview
set statusline+=%0*\ %y                                " FileType
set statusline+=%0*\ %{''.(&fenc!=''?&fenc:&enc).''}     " Encoding
set statusline+=\ (%{&ff})                               " FileFormat (dos/unix..)
set statusline+=%=                                       " Right Side
set statusline+=%0*\ colo:\%02l\                         " Colomn number
set statusline+=%0*\ line:\%02v\ (%3p%%)\              " Line number / total lines, percentage of document
