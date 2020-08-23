" vim-lsp
"
" Add keybindings for use with a scala language server. Language server setup
" is expected to be managed by another plugin
"
" See https://github.com/scalameta/metals
" See https://scalameta.org/metals/docs/editors/vim.html#using-an-alternative-lsp-client
" See https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Scala
augroup LspScala
    " Jump to definition with LSP instead of tagsrch
    autocmd FileType scala,sbt nmap <buffer> <C-]> <plug>(lsp-definition)
    " Get "hover" information from LSP instead of man
    autocmd FileType scala,sbt nmap <buffer> <S-k> <plug>(lsp-hover)
    " Use lsp#complete as the omni completion function
    autocmd FileType scala,sbt setlocal omnifunc=lsp#complete
augroup END
