class Student < User
  before_save {|record| 
		self.role = 'student'
		}
  # 学生 # 家长都放在这里 但是还要用role来区分
  belongs_to :school_class
  validates :school_class_id, presence: true
  delegate :work_papers, :to => :school_class, :allow_nil => true

  has_many :home_works
  
  def class_no
  	self.school_class.class_no unless self.school_class.nil?
  end
end