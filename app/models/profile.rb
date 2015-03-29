class Profile < ActiveRecord::Base
  belongs_to :user, touch: true
  mount_uploader :avatar, AvatarUploader
end
