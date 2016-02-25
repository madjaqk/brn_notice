class SessionsController < ApplicationController
	def create
		if request.env['omniauth.auth']
			begin
				@user = User.from_omniauth(request.env['omniauth.auth'])
				session[:user_id] = @user.id 
				flash[:success] = "Welcome, #{@user.first_name}!"
				redirect_to "/users/#{@user.id}"
			rescue
				flash[:warning] = "There was an error authenticating you..."
				redirect_to "/login"
			end
		else
			user = User.find_by email: params[:email]
			if user 
				if user.authenticate(params[:password])
					session[:user_id] = user.id 
					redirect_to "/users/#{user.id}"
				else
					flash[:errors] = "Incorrect password"
					redirect_to "/login"
				end
			else
				flash[:errors] = "E-mail address not found"
				redirect_to "/login"
			end
		end
	end

	def destroy
		if current_user
			session.delete(:user_id)
			flash[:success] = "Logged out"
		end
		redirect_to root_path
	end

	def auth_failure
		redirect_to root_path
	end
end
