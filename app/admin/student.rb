ActiveAdmin.register Student do


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
      image_tag "#{v.avatar.url}?imageView2/1/w/128" unless v.avatar.url.blank?
    end
    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "Student Info" do
      f.input   :nickname
      f.input   :email
      f.input   :password
      f.input   :password_confirmation
      f.input   :avatar, as: :file, :hint => f.object.avatar.url.blank? ? f.content_tag(:span, "no image yet") : f.image_tag("#{f.object.avatar.url}?imageView2/1/w/256")
      f.input   :avatar_cache, :as => :hidden
    end

    f.actions
  end
end
