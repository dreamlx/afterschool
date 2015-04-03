ActiveAdmin.register Profile do

  permit_params :avatar, :address, :birthday, :gender, :user_id, :student_number

      # f.input   :avatar, as: :file, :hint => f.object.avatar.url.blank? ? f.content_tag(:span, "no image yet") : f.image_tag("#{f.object.avatar.url}?imageView2/1/w/256")
      # f.input   :avatar_cache, :as => :hidden

  index do
    column :user do |p|
      if p.user
        link_to p.user.nickname, admin_student_path(p.user.id) unless p.user.role == 'student'
        link_to p.user.nickname, admin_teacher_path(p.user.id) unless p.user.role == 'teacher'
      end
    end
    column :avatar do |p|
      image_tag p.avatar.url, size: '128x128' unless p.avatar.nil?
    end
    column :address
    column :postalcode
    actions
  end
end
