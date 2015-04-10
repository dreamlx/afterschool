ActiveAdmin.register WorkPaper do

  permit_params :title, :teacher_id, :paper_type, :description, :school_classes, :school_class_ids, 
                media_resources_attributes: [:id, :avatar, :_destroy,:description]

  #TODO, 在show页面选择发布的班级

  show do |work_paper|
    
    attributes_table do 
      row :title
      row :description
      row :paper_type
      row :teacher do |t|
        t.teacher.nickname
      end
    end

    panel t('class_list') do
      table_for(work_paper.school_classes) do |s|
        s.column :id
        s.column  "class_no" do |c|
          link_to c.class_no, admin_school_class_path(c)
        end
      end
    end
 
    panel t('MediaResource') do
      table_for(work_paper.media_resources) do |m|
        m.column  :id
        # m.column "url" do |f|
        #   link_to f.avatar, admin_media_resource_path(f)
        # end
        m.column "type" do |f|
          link_to f.content_type, admin_media_resource_path(f)
        end
      end
    end

  end

  form(:html => { :multipart => true }) do |f|
    f.inputs 'WorkPaper' do 
      f.input   :title
      f.input   :description
      f.input   :paper_type, as: :select, collection: ["text", 'image', 'sound', 'video']
      f.input   :teacher_id, as: :select, collection: Teacher.all { |t| [t.nickname, t.id] }
    end

    f.inputs 'Class' do
      f.input :school_classes, as: :check_boxes
    end

    f.inputs 'MediaResource' do 
      f.has_many :media_resources, :allow_destroy => true, :new_record => true do |mr|

        mr.input :avatar, as: :file, :hint => (mr.object.avatar.url unless mr.object.avatar.url.blank?)
        mr.input :description
      end
    end
    f.actions
  end

  controller do
    def create
      create!
      ids = params['work_paper']['school_class_ids']
      
      ids.each do |id|
        sc = @work_paper.class_papers.create!(school_class_id: id) if id != ""
      end
    end

    def update
      ids = params['work_paper']['school_class_ids']
      wk = WorkPaper.find(params[:id])
      wk.class_papers.destroy_all
      
      ids.each do |ii|        
        wk.class_papers.create!(school_class_id: ii) unless ii.blank?
        wk.save
      end
              
      work_paper = params["work_paper"]
      update!
    end

    # def scoped_collection
    #   work_papers = WorkPaper.all
    #   work_papers = WorkPaper.where("teacher_id = #{current_user.id}") if current_user.role == 'teacher'
    # end
  end

end 
