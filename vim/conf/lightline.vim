" Lightline
let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'filename' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'filetype' ] ]
  \ },
  \ 'component_function': {
  \   'filename': 'ComboFilename',
  \ },
  \ }

function! BjsModified()
  if &modified && &modifiable
    return "+"
  else
    return ""
  endif
endfunction

function! BjsReadonly()
  if &readonly
    return "!!"
  else
    return ""
  endif
endfunction

function! ComboFilename()
  return ('' != BjsReadonly() ? BjsReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != BjsModified() ? ' ' . BjsModified() : '')
endfunction
