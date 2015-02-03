class MediaResource < ActiveRecord::Base

  belongs_to :work_paper
  
  mount_uploader :avatar, MediaUploader
  # serialize :avatars, Array

end