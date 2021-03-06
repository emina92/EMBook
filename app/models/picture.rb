class Picture < ActiveRecord::Base
  belongs_to :album
  belongs_to :user

  has_attached_file :asset, styles: {
    large: "800x800#", medium: "300x200#", small: "260x180#", thumb: "80x80#"
  }
  
  validates_attachment :asset,
  content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

  has_many :comments, as: :commentable
end
