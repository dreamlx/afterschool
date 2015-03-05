class WorkReview < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :home_work
end
