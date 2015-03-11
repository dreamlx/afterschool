class Teacher < User
  before_save {|record| 
		self.role = 'teacher'
		}
  
  # 老师和作业时一对一的关系
  has_many :work_papers
  has_many :work_reviews

  has_many :class_teachers
  has_many :school_classes, through: :class_teachers


end