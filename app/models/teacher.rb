class Teacher < User
  
  # 老师和作业时一对一的关系
  has_many :work_papers

  has_many :class_teachers
  has_many :school_classes, through: :class_teachers


end