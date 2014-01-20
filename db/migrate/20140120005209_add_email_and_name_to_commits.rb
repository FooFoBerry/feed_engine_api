class AddEmailAndNameToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :email, :string
    add_column :commits, :name, :string
  end
end
