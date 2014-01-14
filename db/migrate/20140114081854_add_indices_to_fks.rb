class AddIndicesToFks < ActiveRecord::Migration
  def change
    add_index :commits, :repo_id
    add_index :project_repos, :project_id
    add_index :project_repos, :repo_id
    add_index :projects, :user_id
    add_index :repos, :gh_repo_id, { unique: true }
  end
end
