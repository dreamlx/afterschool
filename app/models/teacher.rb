class Teacher < User

  # 老师 班级  应该也是多对多的关系 TODO
  # 属于某个班级
  belongs_to :school_class

end