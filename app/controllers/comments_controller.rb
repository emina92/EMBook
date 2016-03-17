class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@comment = @commentable.comments.new(comment_params)
		@comment.user = current_user
		@comment.save

		if @commentable.is_a?(Status)
			redirect_to statuses_path(@commentable), notice: "Your comment was successfully posted."
		elsif @commentable.is_a?(Album)
			redirect_to albums_path(@comment.user.profile_name, @commentable), notice: "Your comment was successfully posted."
		else
			redirect_to album_pictures_path(@comment.user.profile_name, @commentable.album, @commentable), notice: "Your comment was successfully posted."
		end
	end

	def destroy
		@comment = @commentable.comments.find(params[:id])
		@comment.destroy

		if @commentable.is_a?(Status)
			redirect_to statuses_path(@commentable), notice: "Your comment was successfully destroyed."
		elsif @commentable.is_a?(Album)
			redirect_to albums_path(@comment.user.profile_name, @commentable), notice: "Your comment was successfully destroyed."
		else
			redirect_to album_pictures_path(@comment.user.profile_name, @commentable.album, @commentable), notice: "Your comment was successfully destroyed."
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end
end
