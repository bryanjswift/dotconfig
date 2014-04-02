" markdown filetype file
if exists("did\_load\_filetypes")
	finish
endif

augroup markdown
	autocmd BufRead *.md 											set ai formatoptions=tcroqn2 comments=n:>
	autocmd BufRead *.markdown 								set ai formatoptions=tcroqn2 comments=n:>
augroup END

augroup textile
	autocmd BufRead *.textile 								set ai formatoptions=tcroqn2 comments=n:>
augroup END

augroup aspx
	autocmd BufRead,BufNewFile *.aspx					set ft=xml
augroup END

augroup velocity
	au! BufRead,BufNewFile *.vm								set ft=velocity
augroup END
