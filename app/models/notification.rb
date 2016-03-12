class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscribed_user
  belongs_to :post
  belongs_to :notified_by, class_name: 'User'
end
