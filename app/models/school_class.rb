class SchoolClass < ActiveRecord::Base

  has_many :class_users
  has_many :school_classes, through: :class_users

  # TODO:has many student, teacher
  

  has_many :class_papers
  has_many :work_papers, through: :class_papers
end
