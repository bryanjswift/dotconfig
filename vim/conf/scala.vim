" Add metals-vim as a language server protocol
" See https://github.com/scalameta/metals
" See https://scalameta.org/metals/docs/editors/vim.html#using-an-alternative-lsp-client
" See https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Scala

" Path to the executable
if executable('metals-vim')
    augroup LspScala
        au User lsp_setup call lsp#register_server({
            \ 'name': 'metals',
            \ 'cmd': {server_info->['metals-vim']},
            \ 'initialization_options': { 'rootPatterns': 'build.sbt' },
            \ 'whitelist': [ 'scala', 'sbt' ],
        \ })
        " Jump to definition with LSP instead of tagsrch
        autocmd FileType scala,sbt nmap <buffer> <C-]> <plug>(lsp-definition)
        " Get "hover" information from LSP instead of man
        autocmd FileType scala,sbt nmap <buffer> <S-k> <plug>(lsp-hover)
        " Use lsp#complete as the omni completion function
        autocmd FileType scala,sbt setlocal omnifunc=lsp#complete
    augroup END
endif
