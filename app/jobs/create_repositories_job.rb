class CreateRepositoriesJob < ApplicationJob
  queue_as :default

  def perform(user)
    login = user.github_username
    GithubApi::Discovery.each_repository(login) do |repo|
      repo_name = repo["name"]

      Repository.find_or_create_by!(
        name: repo_name,
        github_username: login,
      )
    end
  end
end
