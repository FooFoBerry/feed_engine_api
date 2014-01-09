class Commit < ActiveRecord::Base
  validates :commit_hash, presence: true
end
