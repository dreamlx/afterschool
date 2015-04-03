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

  permit_params :email, :password, :password_confirmation, :nickname, :phone, :avatar, :school_classes, :school_class_ids

  filter :email
  filter :nickname
  
  #scope_to Proc.new { Teacher.my_account(current_user.id) if current_user.role == 'teacher' }

  index do 
    column    :role
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
    f.inputs 'Class' do
      f.input :school_classes, as: :check_boxes
    end
    f.actions
  end

  controller do
    def update
      ids = params['teacher']['school_class_ids']
      wk = Teacher.find(params[:id])
      wk.class_teachers.destroy_all
      
      ids.each do |ii|        
        wk.class_teachers.create!(school_class_id: ii) unless ii.blank?
        wk.save
      end
              
      teacher = params["teacher"]
      update!
    end

    # def scoped_collection
    #   Teacher.all
    #   Teacher.where(id: current_user.id) if current_user.role == 'teacher'
    # end
  end


end
