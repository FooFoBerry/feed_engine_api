class Repo < ActiveRecord::Base
  validates :github_url, presence: true
  has_many :commits
  has_many :project_repos
  has_many :projects, through: :project_repos

  after_create :fetch_gh_repo_id

  #def self.create(args)
  #  gh_repo_id = GithubAPI.new(github_url).gh_repo_id
  #  args.merge(:gh_repo_id => gh_repo_id)
  #  raise gh_repo_id.inspect
  #  super(args)
  #end
  #
  # BEFORE SAVE, IF IT's BLANK... add the ID

  private

  def fetch_gh_repo_id
    gh_repo_id = GithubAPI.new(github_url).gh_repo_id
    update_attributes(:gh_repo_id => gh_repo_id)
  end

end
