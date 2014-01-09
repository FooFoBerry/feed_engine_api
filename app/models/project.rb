class Project < ActiveRecord::Base
  validates :name, presence: true
  has_many :commits
end
