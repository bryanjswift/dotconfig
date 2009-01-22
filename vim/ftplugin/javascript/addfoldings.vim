" Plugin to create a folding for every function where the function declaration
" ends the line
" Last Change:		2009 December 8
" Maintainer:			Bryan J Swift
" License:	This file is placed in the public domain.

" see if the script has been run for this buffer already
if exists("b:did_jsfoldings")
	finish
endif
let b:did_jsfoldings = 1

" define a function to fold JavaScript functions
function! JavaScriptFoldFunctions()
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
command! -nargs=0 JavaScriptFoldFunctions :call JavaScriptFoldFunctions()

" call the function
execute "call JavaScriptFoldFunctions()"
