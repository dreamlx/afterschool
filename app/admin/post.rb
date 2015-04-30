ActiveAdmin.register Post do
  
  permit_params :title, :body, :user_id, :school_class_id
  config.comments = false
  
  index do
    column :id 
    column :title
    column :body
    column :user_id do |r|
       r.user.nickname if r.user 
    end
    column :created_at
    actions 
  end
end
