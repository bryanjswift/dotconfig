" Plugin to create a folding for every function where the function declaration
" ends the line
" Last Change:		2008 December 7
" Maintainer:			Bryan J Swift
" License:	This file is placed in the public domain.

" see if the script has been run for this buffer already
if exists("b:did_jsfoldings")
	finish
endif
let b:did_jsfoldings = 1

" if manual search for functions and fold them
if &foldmethod == "manual"
	execute "normal gg"
	while search("function.*(.*) *{$","W") > 0
		execute "normal $"
		execute "normal zf%"
		execute "normal zo"
	endwhile
	execute "normal gg"
elseif &foldmethod == "syntax"
	
endif
