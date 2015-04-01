ActiveAdmin.register Post do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  
  permit_params :title, :body, :user_id
  config.comments = true
  
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
    column :title
    column :body
    column :user_id do |r|
       r.user.nickname if r.user 
    end
    column :created_at
    actions 
  end
end
