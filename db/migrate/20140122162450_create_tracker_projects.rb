class CreateTrackerProjects < ActiveRecord::Migration
  def change
    create_table :tracker_projects do |t|
      t.integer :project_id
      t.integer :tracker_project_id

      t.timestamps
    end
  end
end
