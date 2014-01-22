class ChangeTrackerProjectIdAttributeName < ActiveRecord::Migration
  def change
    rename_column :tracker_projects, :tracker_project_id, :pt_project_id
  end
end
