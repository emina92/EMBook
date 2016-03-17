class Pictures::CommentsController < CommentsController
	before_action :set_commentable

	private

		def set_commentable
			@commentable = Picture.find(params[:picture_id])
		end
end