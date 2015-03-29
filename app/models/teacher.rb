class Teacher < User
  before_save {|record| 
		self.role = 'teacher'
		}

  after_create {|record| self.build_profile }
  
  # 老师和作业时一对一的关系
  has_many :work_papers
  has_many :work_reviews

  has_many :class_teachers
  has_many :school_classes, 	through: :class_teachers
  has_many :students, 			through: :school_classes

  def self.my_account(user_id)
  	Teacher.where("id = #{user_id}")
  end
end