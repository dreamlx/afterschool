ActiveAdmin.register HomeWork do


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

  permit_params :title, 
    :description, 
    :student_id, 
    :work_paper_id, 
    :state, 
    media_resources_attributes: [:id, :avatar, :_destroy,:description],
    work_review_attributes: [:id, :rate, :remark, :home_work_id, :teacher_id]



  index do
    column  :id 
    column  :student
    column  :title
    column  :work_paper
    column  :state

    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs 'HomeWork' do 
      f.input   :student
      f.input   :work_paper
      f.input   :title
      f.input   :description
    end

    f.inputs 'MediaResource' do 
      f.has_many :media_resources, :allow_destroy => true, :new_record => true do |mr|

        mr.input :avatar, as: :file, :hint => (mr.object.avatar.url unless mr.object.avatar.url.blank?)
        mr.input :description
      end
    end

    f.inputs 'work_review' do 
      f.semantic_fields_for :work_review do |j|
        j.input :rate, as: :select, collection: [['A',5],['B',4],['C',3],['D',2],['E',1]]
        j.input :remark, as: :text
        j.input :home_work_id, value: j.object.id, :as => :hidden
      end
    end

    f.actions
  end

  show do |home_work|
    attributes_table do 
      row :title
      row :description
      row :student do |r|
        r.student.nickname unless r.student.nil?
      end
      row :work_paper do |r|
        r.work_paper.title unless r.work_paper.nil?
      end
      row :state
    end

    panel t('MediaResource') do
      table_for(home_work.media_resources) do |m|
        m.column  :id
        m.column "url" do |f|
          link_to f.avatar.url, f.avatar.url, target: '_blank' unless f.avatar.nil?
        end
      end
    end

    panel t('WorkReview') do
      table_for(home_work.work_review) do |m|
        m.column  :id
        m.column  :rate do |r|
          case r.rate.to_i
          when 5
            'A'
          when 4
            'B'
          when 3
            'C'
          when 2
            'D'
          when 1
            'E'
          end
            
        end
        m.column   :remark
      end
    end
  end


end
