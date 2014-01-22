class TrackerProject < ActiveRecord::Base
  validates :pt_project_id, presence: true
end
