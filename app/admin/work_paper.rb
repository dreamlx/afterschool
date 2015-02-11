ActiveAdmin.register WorkPaper do


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


  permit_params :title, :teacher_id, :paper_type, :description, 
                media_resources_attributes: [:id, :avatar, :description]

    
  form(:html => { :multipart => true }) do |f|
    f.inputs 'WorkPaper' do 
      f.input   :title
      f.input   :description
      f.input   :paper_type, as: :select, collection: ["text", 'image', 'sound', 'video']
      f.input   :teacher_id, as: :select, collection: Teacher.all { |t| [t.nickname, t.id] }
    end

    f.inputs do 
      f.has_many :media_resources, :allow_destroy => true, :new_record => true do |mr|
        mr.input :avatar, as: :file
        mr.input :description
      end
    end
    f.actions
  end
end 
