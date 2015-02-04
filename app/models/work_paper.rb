class WorkPaper < ActiveRecord::Base
  
  belongs_to :teacher
  has_many :media_resources


  protected

end


# 一个作业由一个老师来发布 belongs_to :teacher
# 发布的时候选择班级传递给消息。然后发给指定的班级

# CarrierWave 对multiple file的支持所以不用一个miedia 对应一个 resource