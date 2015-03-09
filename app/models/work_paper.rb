class WorkPaper < ActiveRecord::Base
  
  belongs_to :teacher
  validates :teacher_id, presence: true  
  has_many :media_resources, as: :media_resourceable, dependent: :destroy 
  accepts_nested_attributes_for :media_resources,  allow_destroy: true
  

  has_many :class_papers
  has_many :school_classes, through: :class_papers

end


# 一个作业由一个老师来发布 belongs_to :teacher
# 发布的时候选择班级传递给消息。然后发给指定的班级