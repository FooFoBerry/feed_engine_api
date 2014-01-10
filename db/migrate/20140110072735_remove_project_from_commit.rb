class RemoveProjectFromCommit < ActiveRecord::Migration
  def change
    remove_column :commits, :project_id
  end
end
