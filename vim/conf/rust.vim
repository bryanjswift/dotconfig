" Format rust files (.rs) on save
let g:rustfmt_autosave = 1

" Add rls as a language server protocol
if executable('rls')
    augroup LspRust
        au User lsp_setup call lsp#register_server({
            \ 'name': 'rls',
            \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
            \ 'whitelist': ['rust'],
        \ })
        " Jump to definition with LSP instead of tagsrch
        autocmd FileType rust nmap <buffer> <C-]> <plug>(lsp-definition)
        " Get "hover" information from LSP instead of man
        autocmd FileType rust nmap <buffer> <S-k> <plug>(lsp-hover)
        " Use lsp#complete as the omni completion function
        autocmd FileType rust setlocal omnifunc=lsp#complete
    augroup END
endif
