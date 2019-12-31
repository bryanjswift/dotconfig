" Add java-language-server as a language server protocol
" See https://github.com/georgewfraser/java-language-server

" Path to the executable
if executable(expand('~/Documents/code/java/java-language-server/dist/lang_server_mac.sh'))
    augroup LspJava
        au User lsp_setup call lsp#register_server({
            \ 'name': 'java-language-server',
            \ 'cmd': {server_info->[
            \     &shell,
            \     &shellcmdflag,
            \     expand('~/Documents/code/java/java-language-server/dist/lang_server_mac.sh')
            \ ]},
            \ 'whitelist': ['java'],
        \ })
        " Jump to definition with LSP instead of tagsrch
        autocmd FileType java nmap <buffer> <C-]> <plug>(lsp-definition)
        " Get "hover" information from LSP instead of man
        autocmd FileType java nmap <buffer> <S-k> <plug>(lsp-hover)
        " Use lsp#complete as the omni completion function
        autocmd FileType java setlocal omnifunc=lsp#complete
    augroup END
endif
