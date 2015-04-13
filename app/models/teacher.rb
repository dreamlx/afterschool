class Teacher < User
  before_save {|record| 
		self.role = 'teacher'
		}

  after_create {|record| 
    self.build_profile
    self.save
     }
  
  has_many :work_papers
  has_many :home_works, through: :work_papers
  has_many :work_reviews

  has_many :class_teachers
  has_many :school_classes, 	through: :class_teachers
  has_many :students, 			through: :school_classes

  def self.my_account(user_id)
  	Teacher.where("id = #{user_id}")
  end
end