class CreateTrackerEvents < ActiveRecord::Migration
  def change
    create_table :tracker_events do |t|
      t.string :story_url
      t.string :message
      t.string :kind
      t.string :user_name
      t.integer :stroy_id

      t.timestamps
    end
  end
end
