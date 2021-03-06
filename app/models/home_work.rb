

class HomeWork < ActiveRecord::Base

	before_create do |record| 
		self.state = 'init'
	end

	before_save do |record| 
		self.build_work_review if self.work_review.nil?
		self.state = 'complete' unless self.work_review.rate.nil?
	end

	scope :un_review, -> { where(state: 'init') }
	scope :reviewed,  -> { where(state: 'complete') }

	belongs_to :student, required: true
	belongs_to :work_paper, required: true

	delegate :teacher, to: :work_paper
	delegate :school_class, to: :student

	has_one :work_review
	accepts_nested_attributes_for :work_review,  allow_destroy: false

	has_many :media_resources, as: :media_resourceable, dependent: :destroy 
	accepts_nested_attributes_for :media_resources, allow_destroy: true

end
