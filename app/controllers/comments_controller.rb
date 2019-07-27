class CommentsController < ApplicationController

	before_action :find_post,:authenticate_user!

	before_action :correct_user?, only: [:edit,:update,:destroy]

	def create
		@comment = Comment.new(comment_params)

		@comment.user_id = current_user.id
		@comment.post_id = @post.id

		if @comment.save
			redirect_to @post, notice: "Comment posted successfully !"
		else
			redirect_to @post, notice: "Failed to post comment"
		end

	end

	def edit
		@comment = Comment.find(params[:id])
	end

	def update
		@comment = Comment.find(params[:id])

		if @comment.update(comment_params)
			redirect_to @post, notice: "Comment updated successfully !"
		else
			render "edit"
		end
	end

	def destroy
		@comment = Comment.find(params[:id])

		@comment.destroy

		redirect_to @post, notice: "Comment deleted successfully !"
	end


	private

	def comment_params
		params.require(:comment).permit(:content)
	end

	def find_post
		@post = Post.find(params[:post_id])
	end

	def correct_user?

		@comment = Comment.find(params[:id])

		unless current_user.id == @comment.user_id
			redirect_to root_path, notice: "You cannot change others comments !" 
		end

	end


end
