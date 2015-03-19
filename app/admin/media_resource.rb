ActiveAdmin.register MediaResource do


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
  permit_params :avatar, :description

  show do |media|
    attributes_table do 
      row :id
      row :created_at
      row :updated_at
      if media.content_type =~ /audio/
        row :avatar do |m|
          audio_tag m.avatar.url, controls: true, autobuffer: true 
        end
      end
      if media.content_type =~ /video/
        row :avatar do |m|
          video_tag m.avatar.url, controls: true, autobuffer: true 
        end
      end
      if media.content_type =~ /image/
        row :avatar do |m|
          image_tag m.avatar.url
        end
      end      
      row :description
      row :content_type
      row :file_size
    end
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs 'media' do 
      f.input   :avatar, hint: f.object.avatar.url
      f.input   :description
    end
    f.actions
  end
end
