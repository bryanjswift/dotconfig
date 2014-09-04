" CTRL-P
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_root_markers = ['.gitmodules', '.ctrlp']
let g:ctrlp_switch_buffer = 'e'
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }
let g:ctrlp_extensions = ['buffertag']