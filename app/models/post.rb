class Post < ActiveRecord::Base  
	acts_as_votable
	validates :user_id, presence: true
	belongs_to :user
  	validates :image, presence: true
  	has_many :comments, dependent: :destroy
  	validates :caption, length: { minimum: 3, maximum: 300 }
  	has_many :notifications, dependent: :destroy
  	scope :of_followed_users, -> (following_users) { where user_id: following_users }

  has_attached_file :image, styles: { :medium => "640x" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end 