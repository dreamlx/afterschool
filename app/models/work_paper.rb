class WorkPaper < ActiveRecord::Base
  belongs_to :teacher


  after_create :send_message_to_class(class_ary)


  protected

  def send_message_to_class(class_ary)

  end
end


# 一个作业由一个老师来发布 belongs_to :teacher
# 发布的时候选择班级传递给消息。然后发给指定的班级


# CarrierWave 对multiple file的支持所以不用一个miedia 对应一个 resource