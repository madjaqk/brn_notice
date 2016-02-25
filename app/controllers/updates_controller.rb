class UpdatesController < ApplicationController
	def create
		Update.create(user: current_user, current_weight: params[:current_weight])
		redirect_to "/users/#{current_user.id}"
	end
end
