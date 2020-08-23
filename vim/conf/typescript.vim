if executable('npx')
    augroup LspTs
        " Jump to definition with LSP instead of tagsrch
        autocmd FileType javascript,javascript.jsx,typescript,typescript.tsx nmap <buffer> <C-]> <plug>(lsp-definition)
        " Get "hover" information from LSP instead of man
        autocmd FileType javascript,javascript.jsx,typescript,typescript.tsx nmap <buffer> <S-k> <plug>(lsp-hover)
        " Use lsp#complete as the omni completion function
        autocmd FileType javascript,javascript.jsx,typescript,typescript.tsx setlocal omnifunc=lsp#complete
    augroup END
endif
