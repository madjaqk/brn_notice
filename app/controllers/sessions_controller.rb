class SessionsController < ApplicationController
	def create
		# begin
			@user = User.from_omniauth(request.env['omniauth.auth'])
			session[:user_id] = @user.id 
			flash[:success] = "Welcome, #{@user.first_name}!"
		# rescue
		# 	flash[:warning] = "There was an error authenticating you..."
		# end
		redirect_to root_path
	end

	# def create
	# 	render text: request.env['omniauth.auth'].to_yaml
	# end



	def destroy
		if current_user
			session.delete(:user_id)
			flash[:success] = "Logged out"
		end
		redirect_to root_path
	end
end
