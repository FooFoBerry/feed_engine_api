FactoryGirl.define do
  factory :tracker_event do
    story_url "http://pivotaltracker.com/stories/4"
    message "a story was made"
    kind "story_created"
    user_name "bigfo"
    story_id 1
  end
end
