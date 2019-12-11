" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'vim_lsp'

" Position the vista sidebar on the left
let g:vista_sidebar_position = 'vertical topleft'

" Close the vista window when selecting a tag
let g:vista_close_on_jump = 1

" Fallback to ctags if `vim_lsp` isn't available or returns no results
let g:vista_finder_alternative_executives = ['ctags']

" Do not try to show icons
let g:vista#renderer#enable_icon = 0

" search "tags" or symbols with Vista
nnoremap <leader>t :Vista finder<cr>
