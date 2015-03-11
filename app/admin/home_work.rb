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

  permit_params :title, :description, :student_id, :work_paper_id, :state, media_resources_attributes: [:id, :avatar, :_destroy,:description]

  index do
    column  :id 
    column  :student
    column  :title
    column  :work_paper
    column  :state
    column  :work_review do |h|
      if h.work_review.nil?
        link_to 'work_review(new)', new_admin_work_review_path
      else
        link_to 'work_review(done)', edit_admin_work_review_path(h.work_review)
      end
    end
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
          link_to f.avatar.url, admin_media_resource_path(f)
        end
      end
    end

    panel t('WorkReview') do
      table_for(home_work.work_review) do |m|
        m.column  :id
        m.column :work_review do |w|
          link_to 'new review', new_admin_work_review_path(w)
        end
      end
    end
  end


end
