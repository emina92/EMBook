class Album < ActiveRecord::Base
  belongs_to :user
  has_many :pictures, dependent: :destroy
  has_many :comments, as: :commentable
end
