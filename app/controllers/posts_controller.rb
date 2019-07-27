class PostsController < ApplicationController

	before_action :find_post , only: [:show,:edit,:update,:destroy]

	before_action :authenticate_user! , only: [:new,:create,:edit,:update,:destroy]

	before_action :correct_user? , only: [:edit,:update,:destroy]

	def index
		@posts = Post.all.order("created_at DESC")
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id

		if @post.save
			redirect_to @post ,notice: "Post saved successfully !"
		else
			render "new"
		end
	end

	def show
		@post = Post.find(params[:id])
		@comment = @post.comments.build
	end

	def edit

	end

	def update

		if @post.update(post_params)
			redirect_to @post,notice: "Post updated successfully !"
		else
			render "edit"
		end
	end

	def destroy

		@post.destroy

		redirect_to root_path, notice: "Post deleted successfully !"
	end

	def search

		regexp = Regexp.new(params[:search],"i")

		@matches = []

		Post.all.each do |post|

			if post.title.match(regexp) or post.user.name.match(regexp)
				@matches << post
			end
		end
	end

	private

	def post_params
		params.require(:post).permit(:title,:content)
	end

	def find_post
		@post = Post.find(params[:id])
	end

	def correct_user?

		unless current_user.id == @post.user_id
			redirect_to root_path, notice: "You cannot change others posts !" 
		end

	end


end
