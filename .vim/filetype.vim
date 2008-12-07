" markdown filetype file
if exists("did\_load\_filetypes")
	finish
endif

augroup markdown
	au! BufRead,BufNewFile *.md setfiletype md
augroup END

augroup md
	autocmd BufRead *.md set ai formatoptions=tcroqn2 comments=n:>
augroup END
