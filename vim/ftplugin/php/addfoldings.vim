" Plugin to create a folding for every function where the function declaration
" ends the line
" Last Change:  2012 November 4
" Maintainer:   Bryan J Swift
" License:      This file is placed in the public domain.

" see if the script has been run for this buffer already
if exists("b:did_phpfoldings")
	finish
endif
let b:did_phpfoldings = 1

" define a function to fold PHP functions
function! FoldFunctions()
	if &foldmethod == "manual"
		" if manual search for functions and fold them
		execute "normal gg"
		while search("function.*(.*) *{$","W") > 0
			execute "normal $"
			execute "normal zf%"
			execute "normal zo"
		endwhile
		execute "normal gg"
	elseif &foldmethod == "syntax"
		" if syntax use a regular expression to fold functions
	endif
endfunction

"define the command
command! -nargs=0 FoldFunctions :call FoldFunctions()

" call the function
execute "call FoldFunctions()"
