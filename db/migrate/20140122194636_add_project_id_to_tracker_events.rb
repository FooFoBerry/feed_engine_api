class AddProjectIdToTrackerEvents < ActiveRecord::Migration
  def change
    add_column :tracker_events, :project_id, :integer
    add_index :tracker_events, :project_id
  end
end
