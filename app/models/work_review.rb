class WorkReview < ActiveRecord::Base
	after_save {|record| 
		self.home_work.state = 'complete' if self.home_work
		}
  	belongs_to :teacher
  	belongs_to :home_work

end
