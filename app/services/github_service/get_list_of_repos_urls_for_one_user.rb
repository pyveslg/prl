class GithubService::GetListOfReposUrlsForOneUser
  def initialize(github_username:)
    @user = github_username
  end

  def call
    repos_request = GithubApi::AccessPoints::UserRepositories.new(github_username: @user, type: 'all').call
    if repos_request.success?
      repos_request.data.map{_1.dig('html_url')}
    else
      false
    end
  end
end
