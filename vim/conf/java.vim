" vim-lsp
"
" Add keybindings for use with a java language server. Language server setup
" is expected to be managed by another plugin
"
" See https://github.com/georgewfraser/java-language-server
augroup LspJava
    " Jump to definition with LSP instead of tagsrch
    autocmd FileType java nmap <buffer> <C-]> <plug>(lsp-definition)
    " Get "hover" information from LSP instead of man
    autocmd FileType java nmap <buffer> <S-k> <plug>(lsp-hover)
    " Use lsp#complete as the omni completion function
    autocmd FileType java setlocal omnifunc=lsp#complete
augroup END
