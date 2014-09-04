" Airline
let g:airline_section_b = airline#section#create(['%f'])
let g:airline_section_c = airline#section#create([''])
let g:airline_section_z = airline#section#create(['|%c|'])
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'v'  : 'V',
  \ 'V'  : 'V-L',
  \ 'c'  : 'C',
  \ '^V' : 'V-B',
  \ 's'  : 'S',
  \ 'S'  : 'S-L',
  \ '^S' : 'S-B',
  \ }
