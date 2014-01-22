class Project < ActiveRecord::Base
  validates :name, :user_id, presence: true
  has_many :project_repos
  has_many :repos, through: :project_repos
  has_many :tracker_projects
  has_many :tracker_events, through: :tracker_projects
end
