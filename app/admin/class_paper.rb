ActiveAdmin.register ClassPaper do


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

  index do
    column :id
    column :class_no do |r|
      link_to r.school_class.class_no, admin_school_class_path(r.school_class) unless r.school_class.nil?
    end
    column :paper do |r|
      link_to r.work_paper.title, admin_work_paper_path(r.work_paper) unless  r.work_paper.nil?
    end

    actions
  end

end
