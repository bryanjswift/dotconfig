if executable('npx')
    augroup LspTs
        au User lsp_setup call lsp#register_server({
            \ 'name': 'typescript-language-server',
            \ 'cmd': {server_info->[
                \ &shell,
                \ &shellcmdflag,
                \ 'npx typescript-language-server --stdio'
            \ ]},
            \ 'root_uri':{server_info->lsp#utils#path_to_uri(
                \ lsp#utils#find_nearest_parent_file_directory(
                    \ lsp#utils#get_buffer_path(),
                    \ ['tsconfig.json', 'package.json']
                \ )
            \ )},
            \ 'whitelist': [
                \ 'javascript',
                \ 'javascript.jsx',
                \ 'typescript',
                \ 'typescript.tsx'
            \ ],
        \ })
        " Jump to definition with LSP instead of tagsrch
        autocmd FileType javascript,javascript.jsx,typescript,typescript.tsx nmap <buffer> <C-]> <plug>(lsp-definition)
        " Get "hover" information from LSP instead of man
        autocmd FileType javascript,javascript.jsx,typescript,typescript.tsx nmap <buffer> <S-k> <plug>(lsp-hover)
        " Use lsp#complete as the omni completion function
        autocmd FileType javascript,javascript.jsx,typescript,typescript.tsx setlocal omnifunc=lsp#complete
    augroup END
endif
