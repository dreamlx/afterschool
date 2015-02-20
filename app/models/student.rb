class Student < User

  # 学生 # 家长都放在这里 但是还要用role来区分
  has_many :class_students
  has_many :school_classes, through: :class_students
end