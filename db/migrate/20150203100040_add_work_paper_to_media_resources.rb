class AddWorkPaperToMediaResources < ActiveRecord::Migration
  def change
    add_column :media_resources, :work_paper_id, :integer
  end
end
