class ActivitiesController < ApplicationController
  def index
  	params[:page] ||= 1
  	friend_ids = current_user.friends.map(&:id)
  	@activities = Activity.where("user_id in (?)", friend_ids.push(current_user.id)).order("created_at desc").all.page(params[:page])
  end
end
