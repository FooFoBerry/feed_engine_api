class ChangeProjectIdToTrackerProjectId < ActiveRecord::Migration
  def change
    rename_column :tracker_events, :project_id, :tracker_project_id
  end
end
