class PicturesController < ApplicationController
	def create
		if current_user
			Picture.create(picture: params[:picture_url], user: current_user)
			redirect_to "/users/#{current_user.id}"
		end
	end
end
