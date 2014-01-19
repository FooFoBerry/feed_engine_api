require 'spec_helper'

describe GithubAPI do
  it "accepts a github_url" do
    client = GithubAPI.new("https://github.com/foofoberry/github_notification_dummy_app")
    expect(client.username).to eq("foofoberry")
    expect(client.repo_name).to eq("github_notification_dummy_app")
    expect(client.gh_repo_id).to eq(16033562)
  end
end
