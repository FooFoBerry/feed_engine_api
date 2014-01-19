require 'faraday'

class GithubAPI

  attr_reader :github_url,
              :username,
              :repo_name

  def initialize(github_url)
    @github_url = github_url
    @username = username
  end

  def gh_repo_id
    response = Faraday.get("https://api.github.com/repos/#{username}/#{repo_name}")
    body = JSON.parse(response.body)
    puts body
    body[:id]
  end

  def username
    parsed_url[-2]
  end

  def repo_name
    parsed_url[-1]
  end

  def parsed_url
    @parsed_url ||= github_url.split("/")
  end

end
