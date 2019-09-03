" Format rust files (.rs) on save
let g:rustfmt_autosave = 1

" ALE configuration
"" ALE will use `cargo check` instead of `cargo build`
let g:ale_rust_cargo_use_check = 1
"" ALE will set the `--tests` option when `cargo check` is used.
"" This allows for linting of tests which are normally excluded.
let g:ale_rust_cargo_check_tests = 1

" Add rls as a language server protocol
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
        \ 'whitelist': ['rust'],
        \ })
endif
