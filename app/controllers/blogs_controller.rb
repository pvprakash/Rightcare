class BlogsController < ApplicationController
	def index
		@blogs = Blog.all.paginate(:page => params[:page], :per_page => 3)
		@popular_blogs = Blog.order("blogs.hit_counts DESC").limit(3)
	end

	def archive
		begin
		month = params[:m]
		year = params[:y]
		@blogs = Blog.where("extract(month from created_at) = ? AND extract(year from created_at) =?", month, year)
		.paginate(:page => params[:page], :per_page => 3)
		@popular_blogs = Blog.order("blogs.hit_counts DESC").limit(3)
		rescue Exception
	  	flash[:error] = "something went wrong"
	    redirect_to blogs_path
	  end
	end

	def show
		begin
			@blogs = Blog.all.paginate(:page => params[:page], :per_page => 3)
			@popular_blogs = Blog.order("blogs.hit_counts DESC").limit(3)
			@blog = Blog.find(params[:id])
			@blog.update_attributes(hit_counts: @blog.hit_counts+1)
	  rescue Exception
	  	flash[:error] = "something went wrong"
	    redirect_to blogs_path
	  end
	end
end
