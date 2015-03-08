class HomeWork < ActiveRecord::Base
	before_create {|record| 
		self.state = 'init'
		}

	belongs_to :student
	belongs_to :work_paper
	has_one :work_review

	has_many :media_resources, as: :media_resourceable, dependent: :destroy 
	accepts_nested_attributes_for :media_resources,  allow_destroy: true

end
