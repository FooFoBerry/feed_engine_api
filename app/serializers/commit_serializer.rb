class CommitSerializer < ActiveModel::Serializer
  attributes :id, :message, :username, :email, :repo_id,
             :created_at, :commit_hash, :tiny_hash, :creation_date,
             :name, :additions, :deletions, :repo_name

  def tiny_hash
    object.commit_hash[0...6]
  end

  def creation_date
    object.created_at.to_i * 1000
  end

  def repo_name
    name = object.repo.github_url.split('/').last
    if name == "github_notification_dummy_app"
      fake_names.sample
    else
      name
    end
  end

  def fake_names
    [
      "foofoberry",
      "feed_engine_api",
      "feed_engine_auth",
      "rails",
      "costners_goes_postal"
    ]
  end

  def stats
    @stats ||= client.commit(repo_url, commit_hash).stats
  end

  def client
    @client ||= Octokit::Client.new(
      :client_id => "b38f5e35c8e5af8ec3e2",
      :client_secret => "8fcb53f99a91fe0e1ef7c910ea92d51d20be6fff")
  end

  def repo_url
    object.repo.github_url
  end

  def additions
    stats.additions
  end

  def deletions
    stats.deletions
  end
end
