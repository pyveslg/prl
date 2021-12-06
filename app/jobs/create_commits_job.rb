class CreateCommitsJob < ApplicationJob
  queue_as :default

  def perform(repository)
    api = Github::Api.new
    api.each_commit(repository.github_username, repository.name) do |commit|
      next if commit.dig("committer", "email") == "noreply@github.com"

      hash = commit["id"]
      next if Commit.where(github_id: hash).any?

      author_login = commit.dig("author", "user", "login")
      author = User.find_by(github_username: author_login)
      next if author.nil?

      message = commit["message"].lines.first.strip

      puts "#{repository.full_name}: <#{author_login}> #{message}"
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
