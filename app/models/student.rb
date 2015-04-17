class Student < User
  before_save {|record| 
		self.role = 'student'
		}

  after_create {|record| 
    self.build_profile 
    self.save

  }

  belongs_to :school_class, required: true
#  validates :school_class_id, presence: true
  delegate :work_papers, :to => :school_class, :allow_nil => true

  has_many :home_works

  scope :of_class, ->(cid){ where("school_class_id=#{cid}") }
  
  def class_no
  	self.school_class.class_no unless self.school_class.nil?
  end
end