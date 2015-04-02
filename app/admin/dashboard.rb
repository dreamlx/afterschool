ActiveAdmin.register_page "Dashboard" do

 
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  
  
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

 menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container" do
      span class: "blank_slate" do
        h3 do
            "测试中,3-30，有问题请向email:dreamlinx@gmail.com 报告"
        end
        ul do
            ol do 
                link_to '1 create school class', new_admin_school_class_path
            end
            ol do
               link_to '2 create teacher', new_admin_teacher_path
            end

            ol do
                link_to '3 create student', new_admin_student_path
            end
            ol do
                link_to '4 create WorkPaper', new_admin_work_paper_path
            end
            ol do
                link_to '5 wait for students submit HomeWork', admin_home_works_path
            end
            ol do
                span '6 review student WorkReviews in HomeWork'
            end
        end
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
