class CreateCommitsJob < ApplicationJob
  queue_as :default

  def perform(repository)
    api = Github::Api.new
    api.each_commit(repository.github_username, repository.name) do |commit|
      create_commit(
        repository: repository,
        hash: commit[:id],
        email: commit.dig(:committer, :email),
        username: commit.dig(:author, :user, :login),
        message: commit[:message].lines.first.strip,
        date: commit[:committedDate],
      )
    end
  end

  private

  # rubocop:disable Metrics/ParameterLists
  def create_commit(repository:, hash:, email:, username:, message:, date:)
    return if email == "noreply@github.com"
    return if Commit.where(github_id: hash).any?

    author = User.find_by(github_username: username)
    return if author.nil?

    Commit.create!(
      user: author,
      github_id: hash,
      message: message,
      message_date: date,
      repository: repository,
    )
  end
  # rubocop:enable Metrics/ParameterLists
end
