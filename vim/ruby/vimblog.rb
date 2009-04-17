require 'xmlrpc/client.rb'
require 'time.rb'
class Vimblog

	#######
	# class variable definitions
	@post = {}
	@publish = true
	#@config defined in initialize
	#@xmlrpc defined in initialize

	#######
	# class initialization. Instantiates the @xmlrpc class variable to
	# retain blog site information for future api calls
	#
	def initialize
		@blogdatafile = File.expand_path(VIM::evaluate("g:blogconfig"))
		begin
			@config = get_personal_data
			blogconfig = @config[VIM::evaluate("a:blog")]
			@xmlrpc = XMLRPC::Client.new(blogconfig[:site], blogconfig[:xml], blogconfig[:port])
			self.send("blog_"+VIM::evaluate("a:start"))
		rescue XMLRPC::FaultException => e
			xmlrpc_flt_xcptn(e)
		rescue StandardException => e
			puts 'Configuration file not found. Please set g:blogconfig in your runtime path.'
		end
	end

	#######
	# class variables for personnal data.
	def get_personal_data
		if File.exist?(@blogdatafile)
			configdata = IO.readlines(@blogdatafile)
		else
			raise StandardException, 'Configuration not defined'
			return
		end
		tempconfig = {}
		configdata.each { |data|
			if data.strip =~ /^(.+?)\s+(\d+):(\w+?):(.*?)\s+https?:\/\/(\d+):(.*?):(\d+)(\/.*)/
				tempconfig[$1] = {
					:login => $3,
					:passwd => $4,
					:site => $6,
					:xml => $8 ? $8 : '/xmlrpc.php',
					:port => $7 ? $7 : 80,
					:blog_id => $5 ? $5 : 0,
					:user => $2 ? $2 : 1
				}
			end
		}
		return tempconfig
	end

	def get_post_content
		post_content = {}
		in_headers = true
		buffer = VIM::Buffer.current
		num_lines = buffer.count
		current = 1;
		while current <= num_lines
			line = buffer[current]
			current = current + 1
			if in_headers
				if line =~ /^(\w+):[ ]*(.+)/
					key = $1.downcase.to_sym
					case key
						when :category
							@post[:categories] = [] unless @post[:categories]
							@post[:categories].push($2)
						when :status
							@publish = false if $2 =~ /draft/i
						else
							@post[key] = $2
					end
				else
					in_headers = false
				end # line =~
			else
				@post[:description] << line
			end # in_headers
		end
		@post[:wp_slug] = @post[:slug] if @post[:slug]
		@post[:post_id] = @post[:post] if @post[:post]
		return post_content
	end

	#######
	# publish the post. Verifies if it is new post, or an editied existing one.
	#
	def blog_publish
		resp = blog_api("publish", @post, true, @post['new_post'])
		if (@post['new_post'] and resp[:post_id])
		then
			VIM::command("enew!")
			VIM::command("Blog gp #{resp[:post_id]}")
		end
	end

	#######
	# save post as draft. Verifies if it is new post, or an editied existing one.
	#
	def blog_draft
		resp = blog_api("draft", @post, false, @post['new_post'])
		if (@post['new_post'] and resp[:post_id])
		then
			VIM::command("enew!")
			VIM::command("Blog gp #{resp[:post_id]}")
		end
	end

	#######
	# new post. Creates a template for a new post.
	#
	def blog_np
		post_date = same_dt_fmt(Time.now)
		post_author = @user
		VIM::command("call Post_syn_hl()")
		v = VIM::Buffer.current
		v.append(v.count-1, "Title		: ")
		v.append(v.count-1, "Date		 : #{@post_date}")
		v.append(v.count-1, "Comments : 1")
		v.append(v.count-1, "Pings		: 1")
		v.append(v.count-1, "Categs	 : ")
		v.append(v.count-1, " ")
		v.append(v.count-1, " ")
		v.append(v.count-1, "<type from here...> ")
	end

	#######
	# list of categories. Is opened in a new temporary window, because may me for assistance on
	# creating/editing a post.
	#
	def blog_cl
		resp = blog_api("cl")
		# create a new window with syntax highlight.
		# this allows you to rapidelly close the window (:q!) and continue blogging.
		VIM::command(":new")
		VIM::command("call Blog_syn_hl()")
		VIM::command(":set wrap")
		v = VIM::Buffer.current
		v.append(v.count, "CATEGORIES LIST: ")
		v.append(v.count, " ")
		v.append(v.count, "\"#{resp.join('	')}\"")
	end

	#######
	# recent [num] posts. Gets some info for the most recent [num] or 10 posts
	#
	def blog_rp
		VIM::evaluate("a:0").to_i > 0 ? ((num = VIM::evaluate("a:1")).to_i ? num.to_i : num = 10) : num = 10	
		resp = blog_api("rp", num)
		# create a new window with syntax highlight.
		# this allows you to rapidely close the window (:q!) and get that post id.
		VIM::command(":new")
		VIM::command("call Blog_syn_hl()")
		v = VIM::Buffer.current
		v.append(v.count, "MOST RECENT #{num} POSTS:")
		v.append(v.count, "")
		resp.each { |r|
			v.append(v.count, "Post : [#{r[:postid]}]		Date: #{r[:date]}")
			v.append(v.count, "Title: \"#{r[:title]}\"")
			v.append(v.count, " ")
		}
	end

	#######
	# get post [id]. Fetches blog post with id [id], or the last one.
	#
	def blog_gp
		VIM::command("call Post_syn_hl()")
		VIM::evaluate("a:0").to_i > 0 ? ((id = VIM::evaluate("a:1")) ? id : id = nil) : id = nil
		resp = blog_api("gp", id)
		v = VIM::Buffer.current
		v.append(v.count-1, "Post		 : [#{resp[:postid]}]")
		v.append(v.count-1, "Title		: #{resp[:title]}")
		v.append(v.count-1, "Date		 : #{resp[:date]}")
		v.append(v.count-1, "Link		 : #{resp[:link]}")
		v.append(v.count-1, "Permalink: #{resp[:permalink]}")
		v.append(v.count-1, "Author	 : #{resp[:author]}")
		v.append(v.count-1, "Comments : #{resp[:comment_status]}")
		v.append(v.count-1, "Pings		: #{resp[:ping_status]}")
		v.append(v.count-1, "Categs	 : #{resp[:categories]}")
		v.append(v.count-1, " ")
		v.append(v.count-1, " ")
		resp['post_body'].each_line { |l| v.append(v.count-1, l.strip)}
	end

	#######
	# delete post with id [id]. Asks for confirmation first
	#
	def blog_del
		VIM::evaluate("a:0").to_i > 0 ? ((id = VIM::evaluate("a:1")) ? id : id = nil) : id = nil
		resp = blog_api("del", id)
		resp ? VIM.command("echo \"Blog post ##{id} successfully deleted\"") : VIM.command("echo \"Deletion problem for post id ##{id}\"")
	end

	#######
	# insert a link. Is it interesting to implement these options ?
	# ** http://address.com
	# ** title (hint)
	# ** string
	#
	def blog_link
		v = VIM::Buffer.current
		link = {:link => '', :string => '', :title => ''}
		VIM::evaluate("a:0").to_i > 0 ? ((id = VIM::evaluate("a:1")) ? id : id = nil) : id = nil
		v.append(v.count-1, "	a:0 --> #{VIM::evaluate("a:0")}	")
		v.append(v.count-1, "	a:1 --> #{VIM::evaluate("a:1")}	")
		v.append(v.count-1, "<a href=\"#{link[:link]}\" title=\"#{link[:title]}\">#{link[:string]}</a>")
	end

	#######
	# api calls. Always returns a hash so that if api is changed, only this
	# function needs to be changed. One choossse between Blogger, metaWeblog or
	# MovableType very easilly.
	#
	def blog_api(fn_api, *args)
		blogconfig = @config[VIM::evaluate("a:blog")]
		begin
			case fn_api

			when "gp"
				# blog_api('gp', postid)
				# metaWeblog.getPost (postid, username, password) returns struct
				# struct is all post data
				resp = @xmlrpc.call("metaWeblog.getPost", args[0], blogconfig[:login], blogconfig[:passwd])
				post_id = resp['postid']
				@post = {
					:postid => resp['postid'],
					:title => resp['title'],
					:date => same_dt_fmt(resp['dateCreated'].to_time),
					:link => resp['link'],
					:permalink => resp['permalink'],
					:author => resp['userid'],
					:author_name => resp['wp_author_display_name'],
					:slug => resp['wp_slug'],
					:allow_comments => resp['mt_allow_comments'],
					:comment_status => resp['comment_status'],
					:allow_pings => resp['mt_allow_pings'],
					:ping_status => resp['mt_ping_status'],
					:categories => resp['categories'],
					:description => resp['description'],
					:tags => resp['mt_keywords'],
					:status => resp['post_status']
				}
				return @post

			when "rp"
				# blog_api('rp', numposts)
				# metaWeblog.getRecentPosts (blogid, username, password, numberOfPosts) returns array of structs
				# structs are whole post objects
				resp = @xmlrpc.call("metaWeblog.getRecentPosts", blogconfig[:blog_id], blogconfig[:login], blogconfig[:passwd], args[0])
				postarray = []
				resp.each { |r|
					postarray << { :postid => r['postid'], :title => r['title'], :date => r['dateCreated'].to_time }
				}
				return postarray

			when "cl"
				# blog_api('cl')
				# metaWeblog.getCategories (blogid, username, password) returns struct
				# struct = { "categoryId" => 0,"parentId" => 0,"description" => "","categoryName" => "","htmlUrl" => "","rssUrl" => "" }
				resp = @xmlrpc.call("metaWeblog.getCategories", blogconfig[:blog_id], blogconfig[:login], blogconfig[:passwd])
				categories = []
				resp.each { |r| arr_hash << r['categoryName'] }
				return categories

			when "draft"
				# blog_api('draft', @post, publish, new)
				# metaWeblog.newPost(blogid, username, password, struct, publish)
				# metaWeblog.editPost(blogid, username, password, struct, publish)
				# struct = { "title" => "", "link" => "", "description" => "" }
				args[2] ? method = "metaWeblog.newPost" : method = "metaWeblog.editPost"
				args[2] ? which_id = blogconfig[:blog_id] :	which_id = args[0]['post_id']
				resp = @xmlrpc.call(method, which_id, blogconfig[:login], blogconfig[:passwd], args[0], args[1])
				return { [:postid] => resp }

			when "publish"
				# blog_api('publish', @post, publish, new)
				# metaWeblog.newPost (blogid, username, password, struct, publish) returns string
				# metaWeblog.editPost(blogid, username, password, struct, publish)
				# struct = { "title" => "", "link" => "", "description" => "" }
				args[2] ? method = "metaWeblog.newPost" : method = "metaWeblog.editPost"
				args[2] ? which_id = blogconfig[:blog_id] :	which_id = args[0]['post_id']
				resp = @xmlrpc.call(method, which_id, blogconfig[:login], blogconfig[:passwd], args[0], args[1])
				return { [:post_id] => resp }

			when "del"
				# blog_api('del', postid)
				# metaWeblog.deletePost(appkey, postid, username, password, publish) returns boolean
				resp = @xmlrpc.call("metaWeblog.deletePost", "1234567890ABCDE", args[0], blogconfig[:login], blogconfig[:passwd])
				return resp

		 end

		rescue XMLRPC::FaultException => e
			xmlrpc_flt_xcptn(e)
		end
	end

	#######
	# same datetime format for dates
	#
	def same_dt_fmt(dt)
		dt.strftime('%m/%d/%Y %H:%M:%S %Z')
	end

	#######
	# exception handling error display message for communication problems
	#
	def xmlrpc_flt_xcptn(excpt)
		msg = "Error code: #{excpt.faultCode} :: Error msg.:#{excpt.faultString}"
		VIM::command("echo \"#{msg}\"")
	end

	def symbol_to_string(sym)
		case sym
		when :postid
			return "Post"
		else
			return sym.to_s.capitalize
		end
	end

end # class Vimblog
