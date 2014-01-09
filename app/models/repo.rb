class Repo < ActiveRecord::Base
  validates :github_url, presence: true
  has_many :commits
  has_many :project_repos
  has_many :projects, through: :project_repos
end
