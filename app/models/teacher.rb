class Teacher < User
  
  # 老师和作业时一对一的关系
  has_many :work_papers

end