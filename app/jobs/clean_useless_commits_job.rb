class CleanUselessCommitsJob < ApplicationJob
  queue_as :default

  def perform
    Commit
      .where(Commit.arel_table[:message].matches("Merge branch%"))
      .destroy_all
  end
end
