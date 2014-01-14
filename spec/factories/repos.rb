# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :repo do
    github_url "https://github.com/srt32/FE"
    gh_repo_id 15889999
  end
end
