class HomeWork < ActiveRecord::Base
  belongs_to :student
  belongs_to :work_paper
end
