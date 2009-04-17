"	Requirements:
"	- you'll need VIM compiled with Ruby scripting support
"		- example: for Debian/Ubuntu: sudo apt-get install vim-ruby
"	- please, copy this file to one of your VIM dir
"		- example: to your .vim home folder: $HOME/.vim/vimlog.vim
"	- please, add this code to your .vimrc file:
"
"			if !exists('*Wordpress_vim')
"				runtime vimblog.vim
"			endif
"
"	- change your blog login/password info on the get_personal_data function below.
"	- make sure you have xmlrpc.php file in your / blog dir. If not, change the @xml variable to find it.
"	- testing: open vim, and do the following to get your recent 10 posts.
"			 :Blog rp
"
"	- Questions ? e-mail please ;)
"	- Using it ? please, leave a word ;)

if !has('ruby')
	finish
endif

"	Vim syntax functions
"	Language:			wordpress_vim
"	Maintainer:		pedro mg <pedro.mota [at] gmail.com>
"	Version:			1.2 alpha 1
"	Last Change:	2009 Jan 10
"	Remark:				Simple functions for vim blogging bundle in ruby.
"	Remark:				Please, if you fine tune this code, send it back
"	Remark:				for version upgrade ;)

function! Blog_syn_hl()		" {{{2
	:syntax clear
	:syntax keyword wpType Post Title Date
	:syntax region wpTitle start=/"/ end=/$/
	:syntax region wpPostId start=/\[/ end=/\]/
	:highlight wpType ctermfg=Green guifg=LightGreen
	:highlight wpTitle cterm=bold ctermfg=Blue guifg=Blue guibg=LightCyan gui=bold
	:highlight wpPostId ctermfg=Red guifg=Red
endfunction
"	}}}2

function! Post_syn_hl()		" {{{3
	:syntax clear
	:runtime! syntax/html.vim	 " content syntax is html hl, except for headers
	:syntax keyword wpType Post Title Date Author Link Permalink Allow Comments Allow Pings Categs
	:syntax region wpPostId start=/\[/ end=/\]/ contained
	:syntax match wpFields /: .*/hs=s+2 contains=wpPostId
	:highlight wpType ctermfg=Green guifg=LightGreen gui=bold
	:highlight wpPostId ctermfg=Red guifg=Red
	:highlight wpFields ctermfg=Blue guifg=Blue guibg=LightCyan
endfunction
"	}}}3

"	Vim blogging function
"	Language:			vim script
"	Interface:		ruby
"	Maintainer:		pedro mg <pedro.mota [at] gmail.com>
"	Version:			1.2 alpha 1
"	Last Change:	2009 Jan 10
"	Remark:				script function for vim blogging bundle in ruby.
"	Remark:				Please, if you fine tune this code, send it back
"	Remark:				for version upgrade ;)
"	Remark:				V1.2 - commands added:
"	Remark:					- Blog link ADDRESS,TITLE,STRING

:command -nargs=* Blog call Wordpress_vim(<f-args>)

function! Wordpress_vim(start, ...)		" {{{1
	call Blog_syn_hl() " comment if you don't wish syntax highlight activation
	try
ruby <<EOF
	begin
		require "#{ENV['HOME']}/.vim/ruby/vimblog"
	rescue LoadError
		require "vimblog"
	end
	Vimblog.new
EOF
	catch /del/
		:echo "Usage for deleting a post:"
		:echo "	:Blog del id"
	catch /draft/
		:echo "Usage for saving a draft of a post:"
		:echo "	:Blog draft"
	catch /publish/
		:echo "Usage for Publishing a post:"
		:echo "	:Blog publish"
	catch /gc/
		:echo "Usage for getting the list of Categories <new window>:"
		:echo "	:Blog cl"
	catch /gp/
		:echo "Usage for Get Post [id]:"
		:echo "	:Blog gp id"
	catch /np/
		:echo "Usage for New Post:"
		:echo "	:Blog np"
	catch /rp/
		:echo "Usage for Recent [x] Posts (defaults to last 10): <new window>"
		:echo "	:Blog rp [x]"
	catch //
		:echo "Usage is :Blog option [arg]"
		:echo " switches:"
		:echo "	- rp [x]	 => show recent [x] posts"
		:echo "	- gp id		=> get post with identification id"
		:echo "	- np			 => create a new post"
		:echo "	- publish	=> publish an edited/new post"
		:echo "	- draft		=> save edited/new post as draft"
		:echo "	- gc			 => get the list of categories"
		:echo "	- del id	 => delete post with identification id"
		:echo "	--- syntax helpers:"
		:echo "	- link ADDRESS,TITLE,STRING	 => insert link <a href='ADDRESS' title='TITLE'>STRING</a> link"
	endtry
endfunction
" }}}1