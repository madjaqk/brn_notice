class UsersController < ApplicationController
	def index
		@users = User.all
		render "index"
	end

	def show
		@user = User.find(params[:id])
		
		begin
			if @user.end_date > Time.new
				@on_diet = true
			else
				@on_diet = false
			end
		rescue
			@on_diet = false
		end

		if @on_diet
			updates = Update.where(user: @user)
			@progress_chart_data = {}
			@goal_weight_data = {@user.end_date => @user.goal_weight}
			updates.each do |update|
				@progress_chart_data[update.created_at] = update.current_weight
				@goal_weight_data[update.created_at] = @user.goal_weight
			end
		end

		@comment = Comment.new
		@pictures = Picture.where(user: current_user).order(:created_at)

		render "show"
	end

	def edit
		@user = User.find(params[:id])
		if current_user != @user
			redirect_to "/users/#{params[:id]}"
		else
			@email_for_form = @user.email if !@user.email.include? "@fakefakefake.fake"
			@default_end_date = (Time.new+60*60*24*90).strftime("%Y-%m-%d") # Default is 90 days from now	

			begin
				if @user.end_date > Time.new
					@on_diet = true
				else
					@on_diet = false
				end
			rescue
				@on_diet = false
			end
		end
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
			redirect_to "/users/#{@user.id}/edit"
		else
			flash[:error] = @user
			redirect_to "/login"
		end
	end

	def update
		user = User.find(params[:id])
		params[:user].each do |key, val|
			user[key] = val if val.length > 0
		end

		if user.valid?
			user.save
		else
			flash[:error] = user.errors.full_messages
		end
		
		redirect_to "/users/#{user.id}"
	end

	def start_diet
		user = current_user
		start_weight = params[:start_weight].to_i
		goal_weight = params[:goal_weight].to_i
		if start_weight < 1
			flash[:error] = "Please enter a start weight"
		elsif goal_weight < 1
			flash[:error] = "Please enter a goal weight"
		elsif start_weight < goal_weight
			flash[:error] = "Don't plan on gaining weight"
		elsif params[:end_date] < Time.now
			flash[:error] = "End date can't be in the past"
		else
			user.start_weight = start_weight
			user.goal_weight = goal_weight
			user.end_date = params[:end_date]
			user.save
			Update.create(user: user, current_weight: start_weight)
		end
		redirect_to "/users/#{user.id}"
	end
end
