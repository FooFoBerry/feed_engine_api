class TrackerProject < ActiveRecord::Base
  validates :pt_project_id, presence: true
  #belongs_to :project 
  has_many :tracker_events
end
