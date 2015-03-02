ActiveAdmin.register SchoolClass do


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

  permit_params :class_no

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
