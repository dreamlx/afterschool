class SchoolClass < ActiveRecord::Base
  has_many :teachers
  has_many :students

  has_many :class_papers
  has_many :work_papers, through: :class_papers
end
