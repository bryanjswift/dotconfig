" set the leader key for commands
let mapleader = ","

" map shortcuts
" shortcuts for fuzzyfinder plugin
map <leader>f :FuzzyFinderFile<CR>
map <leader>b :FuzzyFinderBuffer<CR>
" shortcut for fuzzyfinder_textmate
map <leader>t :FuzzyFinderTextMate<CR>
" shortcuts for scratch plugin
map <leader>s :Sscratch<CR>
" enables cmd-# to switch between tabs
map <D-1> :tabn1<CR>
map <D-2> :tabn2<CR>
map <D-3> :tabn3<CR>
map <D-4> :tabn4<CR>
map <D-5> :tabn5<CR>
map <D-6> :tabn6<CR>
map <D-7> :tabn7<CR>
map <D-8> :tabn8<CR>
map <D-9> :tabn9<CR>
map <D-0> :tabn10<CR>
" shortcuts for javascript ftplugin
map <leader>jsff zE:JavaScriptFoldFunctions<CR>

" general settings
" backup files to the .vim directory rather than the current directory
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
" show line numbers and ruler all the time
set number
set ruler
" search ignores case and doesn't highlight all finds
set ignorecase
set nohlsearch
set incsearch
" tabwidth = 2 spaces
set ts=2
set shiftwidth=2
" set fold method to manual
set foldmethod=manual
" set acceptable file formats
set ffs=dos,unix

" allow for filetype specific things
filetype plugin on
