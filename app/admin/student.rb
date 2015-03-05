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
  permit_params :email, :password, :password_confirmation, :nickname, :phone, :avatar, :school_class_id

  index do 
    column   :email
    column   :class_no do |s|
      link_to s.class_no, admin_school_class_path(s.school_class) unless s.school_class.nil?
    end
    column   :nickname
    column   :avatar do |v|
      image_tag "#{v.profile.avatar.url}?imageView2/1/w/128" unless  v.profile.nil? or v.profile.avatar.url.blank?
    end
    column :profile do |v|
        link_to 'edit profile', edit_admin_profile_path(v.profile)
      end
    actions
  end

  show do |st|
    attributes_table do
      row :avatar do |v|
        image_tag "#{v.profile.avatar.url}?imageView2/1/w/128" unless  v.profile.nil? or v.profile.avatar.url.blank?
      end 
      row :email
      row :nickname
      row :phone
      row :school_class do |s|
        s.class_no
      end
      row :student_number do |s|
        s.profile.student_number unless s.profile.nil?
      end

      row :birthday do |s|
        s.profile.birthday unless s.profile.nil?
      end

      row :gender do |s|
        s.profile.gender unless s.profile.nil?
      end

      row :address do |s|
        s.profile.address unless s.profile.nil?
      end

      row :profile do |s|
        link_to 'edit profile', edit_admin_profile_path(s.profile)
      end
    end
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "Student Info" do
      f.input   :nickname
      f.input   :email
      f.input   :school_class, as: :select
      f.input   :password
      f.input   :password_confirmation
      
    end

    f.actions
  end
end
