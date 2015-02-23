class MediaResource < ActiveRecord::Base

  belongs_to :media_resourceable, :polymorphic => true
  
  mount_uploader :avatar, MediaUploader
  

  # serialize :avatars, Array
end