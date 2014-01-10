class Commit < ActiveRecord::Base
  validates :commit_hash, presence: true
  belongs_to :repo
end
