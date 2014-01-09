class CreateProjectRepos < ActiveRecord::Migration
  def change
    create_table :project_repos do |t|
      t.integer :project_id
      t.integer :repo_id

      t.timestamps
    end
  end
end
