" Add pyls as a language server protocol
if executable('pyls')
    augroup LspPython
        au User lsp_setup call lsp#register_server({
            \ 'name': 'pyls',
            \ 'cmd': {server_info->['pyls']},
            \ 'whitelist': ['python'],
        \ })
        " Jump to definition with LSP instead of tagsrch
        autocmd FileType python nmap <buffer> <C-]> <plug>(lsp-definition)
        " Get "hover" information from LSP instead of man
        autocmd FileType python nmap <buffer> <S-k> <plug>(lsp-hover)
        " Use lsp#complete as the omni completion function
        autocmd FileType python setlocal omnifunc=lsp#complete
    augroup END
endif
