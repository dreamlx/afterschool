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

	belongs_to :student, required: true
	belongs_to :work_paper, required: true
	delegate :teacher, :to => :work_paper

	has_one :work_review
	accepts_nested_attributes_for :work_review,  allow_destroy: false

	has_many :media_resources, as: :media_resourceable, dependent: :destroy 
	accepts_nested_attributes_for :media_resources,  allow_destroy: true

end
