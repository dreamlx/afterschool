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
      r.school_class.class_no unless r.school_class.nil?
    end
    column :paper do |r|
      r.work_paper.title unless  r.work_paper.nil?
    end

    actions
  end

end
