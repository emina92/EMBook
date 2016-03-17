class Statuses::CommentsController < CommentsController
	before_action :set_commentable

	private

		def set_commentable
			@commentable = Status.find(params[:status_id])
		end
end