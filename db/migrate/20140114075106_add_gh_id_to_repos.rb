class AddGhIdToRepos < ActiveRecord::Migration
  def change
    add_column :repos, :gh_repo_id, :integer
  end
end
