class CleanOldCommitsJob < ApplicationJob
  queue_as :default

  def perform
    Commit.where(created_at: ..2.months.ago).where(score: ..0).destroy_all
  end
end
