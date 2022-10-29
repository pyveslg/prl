class GithubService::FindCommonRepos
  def initialize(github_usernames:)
    @users = github_usernames
  end

  def call
    users_repos = @users.map{GithubService::GetListOfReposUrlsForOneUser.new(github_username: _1).call}
    users_repos[0].intersection(*users_repos[1..-1])
  end
end
