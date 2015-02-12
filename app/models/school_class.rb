class SchoolClass < ActiveRecord::Base
  
  has_many :students
  
  # 
  has_many :class_teachers
  has_many :teachers, through: :class_teachers
  

  has_many :class_papers
  has_many :work_papers, through: :class_papers
end
