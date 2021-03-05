class CreateCommitsJob < ApplicationJob
  queue_as :default

  def perform(user)
    login = user.github_username
    GithubApi::Discovery.each_repository(login) do |repo|
      GithubApi::Discovery.each_commit(login, repo["name"]) do |commit|
        next if Commit.where(github_id: commit["id"]).any?
        next if commit["message"].size > 200
        next if commit["message"].include?("Merge")

        Commit.create!(
          user: user,
          github_id: commit["id"],
          message: commit["message"],
          message_date: commit["committedDate"],
        )
      end
    end
  end
end
