class Activity < ActiveRecord::Base
	belongs_to :user
	belongs_to :targetable, polymorphic: true

	self.per_page = 2
end
