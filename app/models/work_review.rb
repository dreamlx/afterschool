class WorkReview < ActiveRecord::Base
	
	after_save do |record| 
		self.home_work.state = 'complete' if self.home_work
	end
	
	belongs_to :teacher
	belongs_to :home_work

  has_many :media_resources, as: :media_resourceable, dependent: :destroy 
  accepts_nested_attributes_for :media_resources,  allow_destroy: true


end
