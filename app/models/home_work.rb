class HomeWork < ActiveRecord::Base
	before_create {|record| 
		self.state = 'init'
		}

	before_save {|record| 
		if self.work_review.nil?
			self.build_work_review 
		else
			self.state = 'complete' unless self.work_review.rate.nil?
		end
	}
	belongs_to :student
	belongs_to :work_paper
	delegate :teacher, :to => :work_paper
	has_one :work_review

	has_many :media_resources, as: :media_resourceable, dependent: :destroy 
	accepts_nested_attributes_for :media_resources,  allow_destroy: true
	accepts_nested_attributes_for :work_review,  allow_destroy: false

end
