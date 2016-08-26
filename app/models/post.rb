class Post < ActiveRecord::Base  
	acts_as_votable
	validates :user_id, presence: true
	belongs_to :user
  	validates :image, presence: true
  	has_many :comments, dependent: :destroy
  	validates :caption, length: { minimum: 3, maximum: 300 }
  	has_many :notifications, dependent: :destroy
  	scope :of_followed_users, -> (following_users) { where user_id: following_users }

  has_attached_file :image, styles: { :medium => "640x" }, :storage => :s3, :s3_credentials => Proc.new{|a| a.instance.s3_credentials }
  
  def s3_credentials
      {:bucket => "ainor-photogrm", :access_key_id => ENV["AWS_ACCESS_KEY_ID"], :secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"]}
  end
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end 