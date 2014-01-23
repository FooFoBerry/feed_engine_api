class UpdateAttributesOnTrackerEvents < ActiveRecord::Migration
  def change
    add_column :tracker_events, :change_type, :string
    add_column :tracker_events, :story_title, :string
    add_column :tracker_events, :user_initials, :string
  end
end
