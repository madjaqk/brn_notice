class UsersController < ApplicationController
	def index
		render "index"
	end

	def show
		@user = User.find(params[:id])
		render "show"
	end

	def new
		@new_user = User.new
		render "new"
	end

	def create
		@user = User.from_register_form(params)
		if @user.is_a?(User)
			session[:user_id] = @user.id
			flash[:success] = "Account created"
			redirect_to "/users/#{@user.id}"
		else
			flash[:error] = @user
			redirect_to "/login"
		end
	end
end
