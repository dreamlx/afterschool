class ClassTeacher < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :school_class
end
