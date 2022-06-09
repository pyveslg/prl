class CleanUselessCommitsJob < ApplicationJob
  queue_as :default

  def perform
    Commit.where("message ILIKE ANY (array[?])", COMMON_MESSAGES).destroy_all
  end

  COMMON_MESSAGES = [
    "merge master",
    "merge",
    "merged",
    ".",
    "done",
    "ok",
    "Add dotenv - Protect my secret data in .env file",
    "fix",
    "seed",
    "navbar",
    "pull",
    "merging",
    "test",
    "Initial commit with devise template from https://github.com/lewagon/rails-templates",
    "Initial commit with minimal template from https://github.com/lewagon/rails-templates",
    "fixed",
    "changes",
    "update",
    "commit",
    "resolve merge",
    "not done",
    "Done",
    "changes complete",
    "Merge branch%"
  ].freeze
  private_constant :COMMON_MESSAGES
end
