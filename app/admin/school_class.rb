ActiveAdmin.register SchoolClass do

  permit_params :class_no, :avatar

  index do
    column :class_no 
    column :avatar do |p|
      image_tag p.avatar.url, size: '128x128' unless p.avatar.nil?
    end
    actions
  end


  show do |c|
    attributes_table do 
      row :class_no
    end

    panel t('work_papers') do
      table_for(c.work_papers) do |w|
        w.column :id
        w.column  "title" do |r|
          link_to r.title, admin_work_paper_path(r)
        end
      end
    end

    panel t('teachers') do
      table_for(c.teachers) do |t|
        t.column :id
        t.column  "nickname" do |r|
          link_to r.nickname, admin_work_paper_path(r)
        end
      end
    end

    panel t('students') do
      table_for(c.students) do |t|
        t.column :id
        t.column  "nickname" do |r|
          link_to r.nickname, admin_work_paper_path(r)
        end
      end
    end
  end
end