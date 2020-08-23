" vim-lsp
"
" Add keybindings for use with a ruby language server. Language server setup
" is expected to be managed by another plugin
augroup LspRuby
    " Jump to definition with LSP instead of tagsrch
    autocmd FileType ruby nmap <buffer> <C-]> <plug>(lsp-definition)
    " Get "hover" information from LSP instead of man
    autocmd FileType ruby nmap <buffer> <S-k> <plug>(lsp-hover)
    " Use lsp#complete as the omni completion function
    autocmd FileType ruby setlocal omnifunc=lsp#complete
augroup END
