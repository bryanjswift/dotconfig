if executable('solargraph')
    augroup LspRuby
        " gem install solargraph
        au User lsp_setup call lsp#register_server({
            \ 'name': 'solargraph',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
            \ 'initialization_options': {
                \ "diagnostics": "true"
            \ },
            \ 'whitelist': [
                \ 'ruby'
            \ ],
        \ })
        " Jump to definition with LSP instead of tagsrch
        autocmd FileType ruby nmap <buffer> <C-]> <plug>(lsp-definition)
        " Get "hover" information from LSP instead of man
        autocmd FileType ruby nmap <buffer> <S-k> <plug>(lsp-hover)
        " Use lsp#complete as the omni completion function
        autocmd FileType ruby setlocal omnifunc=lsp#complete
    augroup END
endif
