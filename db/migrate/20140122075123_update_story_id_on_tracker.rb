class UpdateStoryIdOnTracker < ActiveRecord::Migration
  def change
    rename_column :tracker_events, :stroy_id, :story_id
  end
end
