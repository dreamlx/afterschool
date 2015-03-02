class Student < User

  # 学生 # 家长都放在这里 但是还要用role来区分
  belongs_to :school_class
  delegate :work_papers, :to => :school_class, :allow_nil => true

  has_many :home_works
  
  def class_no
  	self.school_class.class_no
  end
end