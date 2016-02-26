class CommentsController < ApplicationController
	def create
		comment = Comment.new(comment_params)
		comment.recipient = User.find(params[:comment][:recipient])
		comment.commenter = current_user
		if comment.valid?
			comment.save
		else
			flash[:error] = comment.errors.full_messages
		end
		redirect_to "/users/#{comment.recipient.id}"
	end

	private
	def comment_params
		params.require(:comment).permit(:comment)
	end
end
