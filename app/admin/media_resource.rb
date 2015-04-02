ActiveAdmin.register MediaResource do

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
