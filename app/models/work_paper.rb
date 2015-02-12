class WorkPaper < ActiveRecord::Base
  
  belongs_to :teacher  
  has_many :media_resources, dependent: :destroy 
  accepts_nested_attributes_for :media_resources,  allow_destroy: true

  has_many :class_papers
  has_many :school_classes, through: :class_papers

  has_many :class_teachers
  has_many :teachers, through: :class_teachers

end


# 一个作业由一个老师来发布 belongs_to :teacher
# 发布的时候选择班级传递给消息。然后发给指定的班级