ActiveAdmin.register UserMessage do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :topic, :body, :message_type
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  index do
    column :id 
    column :topic
    column :body
    column :received_user do |m|
      link_to User.find(m.received_messageable_id).nickname, admin_user_path(m.received_messageable_id)
    end
    column :sent_user do |m|
      link_to User.find(m.sent_messageable_id).nickname, admin_user_path(m.sent_messageable_id)
    end
    column :created_at
    actions
  end
end
