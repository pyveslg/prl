class CleanUselessCommitsJob < ApplicationJob
  queue_as :default

  def perform
    Commit.where("message ILIKE 'Merge branch%'").destroy_all
  end
end
