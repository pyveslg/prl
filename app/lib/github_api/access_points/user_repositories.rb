class GithubApi::AccessPoints::UserRepositories < GithubApi::AccessPoints
  def initialize(github_username:, **options)
    @url = "https://api.github.com/users/#{github_username}/repos#{'?' + options.map{"#{_1[0].to_s}=#{_1[1]}"}.join('&') if options.present?}"
    # https://docs.github.com/en/rest/reference/repos#list-repositories-for-a-user
  end
end
