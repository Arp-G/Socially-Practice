class UsersController < ApplicationController

	def index
		@users = User.all.sort{|a,b| a.comments.count <=> b.comments.count}
	end

	def show
		@user = User.find(params[:id])
	end


end
