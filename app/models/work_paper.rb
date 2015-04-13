class WorkPaper < ActiveRecord::Base
  
  belongs_to :teacher, required: true
#  validates :teacher_id, presence: true  
  has_many :media_resources, as: :media_resourceable, dependent: :destroy 
  accepts_nested_attributes_for :media_resources,  allow_destroy: true

  has_many :class_papers
  has_many :school_classes, through: :class_papers
  has_many :home_works
  
  after_save {|record| 
    senduser = Teacher.find(self.teacher_id)
    self.school_classes.each do |sc|
      sc.students.each do |student|
        message_body = "#{senduser.nickname}发布了作业: #{self.title} [work_paper_id: #{self.id}] "
        senduser.send_message(Student.find(student), self.title, message_body, 'work_paper' )
      end
    end
  }

  attr_accessor :count_works, :total_students

  def home_work_state(sid)
  	state = 'none'
    hw = HomeWork.find_by(student_id: sid, work_paper_id: self.id)
  	hw ? hw.state : state
  end
end
