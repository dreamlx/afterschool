class RemoveWorkPaperIdFromMediaResource < ActiveRecord::Migration
  def change
    remove_column :media_resources, :work_paper_id, :integer
  end
end
