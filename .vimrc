" .vimrc
call plugpac#begin()
Pack 'k-takata/minpac', {'type':'opt'}
Pack 'yggdroot/indentline'
Pack 'alvan/vim-closetag'
Pack 'junegunn/fzf.vim'
Pack 'jiangmiao/auto-pairs'
Pack 'preservim/nerdcommenter'
call plugpac#end()

" NERDCOMMENTER
"
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
"let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/*','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" INDENTLINE
"
" autocmd TermOpen * IndentLinesDisable
let g:indentLine_setColors = 1
let g:indentLine_defaultGroup = 'SpecialKey'
let g:indentline_color_term = 239
" none X terminal
let g:indentLine_color_tty_light = 7 " (default: 4)
let g:indentLine_color_dark = 1 " (default: 2)
" Background (Vim, GVim)
let g:indentLine_bgcolor_term = 202
let g:indentLine_bgcolor_gui = '#FF5F00'
" let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" FZF
"
" Preview window is hidden by default. You can toggle it with ctrl-/.
" It will show on the right with 50% width, but if the width is smaller
" than 70 columns, it will show above the candidate list
let g:fzf_preview_window = ['right,50%,<70(up,40%)', 'ctrl-/']
nnoremap <silent> <Leader>s :call fzf#run(fzf#wrap({
			\   'source': 'fd . /home/trunk --hidden --ignore-file /home/trunk/.config/fd/ignore --type file',
			\   'right': '45%',
			\   'sink': 'vertical botright split' }))<CR>
nnoremap <silent> <Leader>e :call fzf#run(fzf#wrap({
			\ 'source': 'fd . /home/trunk --hidden --ignore-file /home/trunk/.config/fd/ignore --type file',
			\ 'popup': 'fp',
			\ 'sink': 'edit' }))<CR>
" This is the default extra key bindings
" An action can be a reference to a function that processes selected lines
" function! s:build_quickfix_list(lines)
"   call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
"   copen
"   cc
" endfunction
" let g:fzf_action = {
"    'ctrl-s': 'vsplit' }
" Open files in horizontal split

" CLOSETAG
"
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
let g:closetag_filetypes = 'html,xhtml,phtml'
" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 1
" dict
" Disables auto-close if not in a "valid" region (based on filetype)
let g:closetag_regions = {
			\ 'typescript.tsx': 'jsxRegion,tsxRegion',
			\ 'javascript.jsx': 'jsxRegion',
			\ 'typescriptreact': 'jsxRegion,tsxRegion',
			\ 'javascriptreact': 'jsxRegion',
			\ }
" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'
" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<leader>>'

" map F3 to start a terminal
noremap <silent> <F3> :vert term<CR>
