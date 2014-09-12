" Lightline
" Used to configure https://github.com/itchyny/lightline.vim
"
let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'filename' ],
  \             [ 'ctrlpmark' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'filetype' ],
  \              [ 'foldmethod' ] ]
  \ },
  \ 'inactive': {
  \   'left': [ [ 'filename' ] ],
  \   'right': [ [ 'filetype' ] ]
  \ },
  \ 'component': {
  \   'foldmethod': '%{&foldmethod}',
  \ },
  \ 'component_function': {
  \   'ctrlpmark': 'LlBjsMark',
  \   'filename':  'LlBjsFilename',
  \   'mode':      'LlBjsMode',
  \ },
  \ }

let g:lightline.mode_map = {
  \ 'n' : 'N',
  \ 'i' : 'I',
  \ 'R' : 'R',
  \ 'v' : 'V',
  \ 'V' : '-V-',
  \ 'c' : 'C',
  \ "\<C-v>": '^V^',
  \ 's' : 'S',
  \ 'S' : '-S-',
  \ "\<C-s>": '^S^',
  \ '?': '   ' }

function! LlBjsModified()
  if &modified && &modifiable
    return "+"
  else
    return ""
  endif
endfunction

function! LlBjsReadonly()
  if &readonly
    return "!!"
  else
    return ""
  endif
endfunction

function! LlBjsFilename()
  let filename = expand('%:t')
  if filename == 'ControlP'
    return g:lightline.ctrlp_item
  elseif filename =~ '__Gundo'
    return ''
  endif

  let readonly = LlBjsReadonly()
  let modified = LlBjsModified()
  " By default '{readonly }{%:t}{ modified}'
  return ('' != readonly ? readonly . ' ' : '') .
       \ ('' != filename ? filename : '[No Name]') .
       \ ('' != modified ? ' ' . modified : '')
endfunction

function! LlBjsMode()
  let filename = expand('%:t')
  if filename == 'ControlP'
    return 'CtrlP'
  elseif filename == '__Gundo__'
    return 'Gundo'
  elseif filename == '__Gundo_Preview__'
    return 'Gundo Preview'
  else
    return lightline#mode()
  endif
endfunction

function! LlBjsMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return g:lightline.ctrlp_next
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'LlBjsCtrlPStatusFunc_1',
  \ 'prog': 'LlBjsCtrlPStatusFunc_2',
  \ }

function! LlBjsCtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! LlBjsCtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction
