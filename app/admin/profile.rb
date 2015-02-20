ActiveAdmin.register Profile do


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

  permit_params :avatar, :address, :birthday, :gender, :user_id, :student_number

      # f.input   :avatar, as: :file, :hint => f.object.avatar.url.blank? ? f.content_tag(:span, "no image yet") : f.image_tag("#{f.object.avatar.url}?imageView2/1/w/256")
      # f.input   :avatar_cache, :as => :hidden


end
