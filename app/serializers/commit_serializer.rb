class CommitSerializer < ActiveModel::Serializer
  attributes :id, :message, :username, :email, :repo_id,
             :created_at, :commit_hash, :tiny_hash, :creation_date,
             :name, :additions, :deletions

  def tiny_hash
    commit_hash[0...6]
  end

  def creation_date
    created_at.to_i * 1000
  end

  def stats
    @stats ||= Octokit.commit(repo_url, commit_hash).stats
  end

  def repo_url
    repo.github_url
  end

  def additions
    stats.additions
  end

  def deletions
    stats.deletions
  end
end
