class TrackerEvent < ActiveRecord::Base
  validates :story_id, presence: true
end
