FactoryGirl.define do
  factory :commit do
    commit_hash "abc123"
    message "I broke all the things"
    username "j3"
    repo_id 1
    email "foofob@example.com"
  end
end
