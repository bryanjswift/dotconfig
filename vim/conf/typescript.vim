if executable('npx')
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
endif
