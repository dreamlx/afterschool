class WorkReview < ActiveRecord::Base
	before_save {|record| 
		self.home_work.state = 'complete'
		}
  	belongs_to :teacher
  	belongs_to :home_work

  	delegate :work_paper, to: :home_work
end
