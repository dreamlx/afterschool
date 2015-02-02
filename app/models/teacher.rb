class Teacher < User

  # 属于某个班级
  belongs_to :school_class
end