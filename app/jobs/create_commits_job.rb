class CreateCommitsJob < ApplicationJob
  queue_as :default

  def perform(user)
    login = user.github_username
    GithubApi::Discovery.each_repository(login) do |repo|
      repo_name = repo["name"]

      repository = Repository.find_or_create_by!(
        name: repo_name,
        github_username: login,
      )

      GithubApi::Discovery.each_commit(login, repo_name) do |commit|
        hash = commit["id"]
        next if Commit.where(github_id: hash).any?

        author_login = commit.dig("author", "user", "login")
        author = User.find_by(github_username: author_login)
        next if author.nil?

        message = commit["message"].lines.first.strip
        puts "#{repository.full_name} @#{author_login} “#{message}”"

        Commit.create!(
          user: author,
          github_id: hash,
          message: commit["message"].lines.first,
          message_date: commit["committedDate"],
          repository: repository,
        )
      end
    end
  end
end
