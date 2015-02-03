class SchoolClass < ActiveRecord::Base
  has_many :teachers
  has_many :students

  # 暂时老师和班级时一对多 之后会调成多对多 
end
