class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string :hash
      t.text :message
      t.string :username
      t.integer :project_id

      t.timestamps
    end
  end
end
