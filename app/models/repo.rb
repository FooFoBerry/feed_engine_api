class Repo < ActiveRecord::Base
  validates :github_url, presence: true
end
