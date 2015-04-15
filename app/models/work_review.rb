class WorkReview < ActiveRecord::Base
	
	after_save do |record| 
		if self.home_work
			self.home_work.state = 'complete' 
#			self.home_work.save!
		end
	end
	
	belongs_to :teacher
	belongs_to :home_work

  has_many :media_resources, as: :media_resourceable, dependent: :destroy 
  accepts_nested_attributes_for :media_resources,  allow_destroy: true


end
