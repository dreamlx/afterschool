ActiveAdmin.register UserMessage do

  permit_params :topic, :body, :message_type


  index do
    h3 do
      "发送班级消息，请下载APP，用手机发"
    end
    
    selectable_column
    column :id 
    column :topic
    column :body
    column :received_user do |m|
      if m.received_messageable_id
        link_to User.find(m.received_messageable_id).nickname, admin_user_path(m.received_messageable_id)
      end
    end
    column :sent_user do |m|
      if m.sent_messageable_id
        link_to User.find(m.sent_messageable_id).nickname, admin_user_path(m.sent_messageable_id)
      end
    end
    column :created_at
    actions
  end
end
