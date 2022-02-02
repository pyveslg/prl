class CleanOldCommitsJob < ApplicationJob
  queue_as :default

  def perform
    Commit.where("created_at < '#{Time.now - 4.month}' ").where('score <= 0').destroy_all
  end
end
