FactoryGirl.define do
  factory :commit do
    commit_hash "abc123"
    message "I broke all the things"
    username "j3"
    project_id 1
  end
end
