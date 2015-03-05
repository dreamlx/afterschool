ActiveAdmin.register Teacher do


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
      image_tag "#{v.profile.avatar.url}?imageView2/1/w/128" unless  v.profile.nil? or v.profile.avatar.url.blank?
    end
    column :profile do |v|
      link_to 'edit profile', edit_admin_profile_path(v.profile) unless v.profile.nil?
    end
    actions
  end
 
  show do |teacher|
    attributes_table do
      row :avatar do |v|
        image_tag "#{v.profile.avatar.url}?imageView2/1/w/128" unless  v.profile.nil? or v.profile.avatar.url.blank?
      end 
      row :email
      row :nickname
      row :phone

      row :birthday do |s|
        s.profile.birthday unless s.profile.nil?
      end

      row :gender do |s|
        s.profile.gender unless s.profile.nil?
      end

      row :address do |s|
        s.profile.address unless s.profile.nil?
      end
      row :profile do |v|
        unless v.profile.nil?
          link_to 'edit profile', edit_admin_profile_path(v.profile) 
        else
          link_to 'new profile', new_admin_profile_path
        end
      end
    end
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "Teacher Info" do
      f.input   :nickname
      f.input   :email
      f.input   :password
      f.input   :password_confirmation
      
    end

    f.actions
  end
end
