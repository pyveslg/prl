class CreateCommitsJob < ApplicationJob
  queue_as :default

  def perform(user)
    login = user.github_username
    GithubApi::Discovery.each_repository(login) do |repo|
      GithubApi::Discovery.each_commit(login, repo["name"]) do |commit|
        hash = commit["id"]
        next if Commit.where(github_id: hash).any?

        author_login = commit.dig("author", "user", "login")
        author = User.find_by(github_username: author_login)
        next if author.nil?

        message = commit["message"].lines.first.strip
        puts "#{author}: “#{message}”"

        Commit.create!(
          user: author,
          github_id: hash,
          message: commit["message"].lines.first,
          message_date: commit["committedDate"],
        )
      end
    end
  end
end
