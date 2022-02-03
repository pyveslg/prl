class CleanUselessCommitsJob < ApplicationJob
  queue_as :default

  def perform
    commons = ["merge master", "merge", "merged", ".", "done", "Eh", "ok", "Add dotenv - Protect my secret data in .env file", "fix", "seed", "navbar", "pull", "merging", "test", "Initial commit with devise template from https://github.com/lewagon/rails-templates", "fixed", "changes", "update", "commit", "resolve merge", "not done", "Done", "changes complete"]
    Commit.where(message: commons).destroy_all
    Commit
      .where(Commit.arel_table[:message].matches("Merge branch%"))
      .destroy_all
  end
end
