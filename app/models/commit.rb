class Commit < ActiveRecord::Base
  validates :commit_hash, presence: true
  validates :email,       presence: true
  belongs_to :repo
end
