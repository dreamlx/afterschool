class Student < User

  # 学生 # 家长都放在这里 但是还要用role来区分
  belongs_to :school_class
end