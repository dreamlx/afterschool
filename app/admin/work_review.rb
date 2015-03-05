ActiveAdmin.register WorkReview do

  permit_params :id, :remark, :teacher_id, :home_work_id, :rate

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


form(:html => { :multipart => true }) do |f|
    f.inputs 'WorkReview' do 
      f.input :teacher
      f.input :home_work
      f.input :rate, as: :select, collection: [['A',5],['B',4],['C',3],['D',2],['E',1]]
      f.input :remark, as: :text
    end

    f.actions
  end
end
