" Format rust files (.rs) on save
let g:rustfmt_autosave = 1

" Add rls as a language server protocol
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'whitelist': ['rust'],
    \ })
endif
