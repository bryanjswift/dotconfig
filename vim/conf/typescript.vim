augroup LspTs
    " Jump to definition with LSP instead of tagsrch
    autocmd FileType javascript,javascriptreact,typescript,typescriptreact nmap <buffer> <C-]> <plug>(lsp-definition)
    " Get "hover" information from LSP instead of man
    autocmd FileType javascript,javascriptreact,typescript,typescriptreact nmap <buffer> <S-k> <plug>(lsp-hover)
    " Use lsp#complete as the omni completion function
    autocmd FileType javascript,javascriptreact,typescript,typescriptreact setlocal omnifunc=lsp#complete
augroup END
