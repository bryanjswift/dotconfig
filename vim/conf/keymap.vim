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
nnoremap <leader>p :FZF<cr>
" search open files/buffers
nnoremap <leader>b :Buffers<cr>

" vim-lsp
"
" search symbols in file
" nnoremap <leader>t :LspDocumentSymbol<cr>

" search symbols in project
nnoremap <leader>o :LspWorkspaceSymbol<cr>

" vista
"
" search "tags" or symbols with Vista
nnoremap <leader>t :Vista finder<cr>
