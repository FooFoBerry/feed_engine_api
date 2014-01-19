class Repo < ActiveRecord::Base
  validates :github_url, presence: true
  has_many :commits
  has_many :project_repos
  has_many :projects, through: :project_repos

  after_create :fetch_gh_repo_id

  private

  def fetch_gh_repo_id
    self.gh_repo_id = GithubAPI.new(self.github_url).gh_repo_id
  end

end
