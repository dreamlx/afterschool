ActiveAdmin.register User do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
  permit_params :email, :password, :password_confirmation, :nickname, :phone, :avatar

  index do 
    column   :email
    column   :nickname
    column   :avatar do |v|
      image_tag "#{v.profile.avatar.url}?imageView2/1/w/128" unless v.profile.nil? or v.profile.avatar.url.blank?
    end
    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "User Info" do
      f.input   :nickname
      f.input   :email
      f.input   :password
      f.input   :password_confirmation
    end

    f.actions
  end

end
