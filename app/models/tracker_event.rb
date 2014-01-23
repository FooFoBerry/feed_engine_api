class TrackerEvent < ActiveRecord::Base
  validates :story_id, presence: true
  belongs_to :tracker_project
end
