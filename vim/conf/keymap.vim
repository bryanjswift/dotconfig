" Defaults
"
" map shortcuts
" relative line numbers
map <D-r> :set relativenumber<CR>
map <D-R> :set norelativenumber<CR>
" easier split navigation
map <down> <C-w><down>
map <up> <C-w><up>
map <left> <C-w><left>
map <right> <C-w><right>

" fzf
"
" search project files
nnoremap <leader>p :Files<cr>
"" ctrl-p binding for files
nnoremap <C-p> :Files<cr>
" search open files/buffers
nnoremap <leader>b :Buffers<cr>
" search open files/buffers
nnoremap <leader><space> :Buffers<cr>
" search availble commands
nnoremap <D-P> :Commands<cr>

" vim-lsp
"
" search symbols in file
" nnoremap <leader>t :LspDocumentSymbol<cr>

" search symbols in project
nnoremap <leader>i :LspWorkspaceSymbol<cr>
"" ctrl-shift-o binding for workspace symbols
nnoremap <C-i> :LspWorkspaceSymbol<cr>

" vista
"
" search "tags" or symbols with Vista
nnoremap <leader>o :Vista finder<cr>
"" ctrl-t binding for tags
nnoremap <C-o> :Vista finder<cr>
