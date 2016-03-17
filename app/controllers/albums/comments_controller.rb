class Albums::CommentsController < CommentsController
	before_action :set_commentable

	private

		def set_commentable
			@commentable = Album.find(params[:album_id])
		end
end