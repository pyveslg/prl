require "test_helper"

class CleanOldCommitsJobTest < ActiveJob::TestCase
  test "#perform" do
    repository = Repository.create!(name: "test", github_username: "test")
    user = User.create!

    commit_1 = Commit.create!(
      repository: repository,
      user: user,
      score: 0,
    )

    commit_2 = Commit.create!(
      repository: repository,
      user: user,
      score: 1,
    )

    commit_3 = Commit.create!(
      repository: repository,
      user: user,
      score: 0,
      created_at: Time.now - 5.months
    )

    commit_4 = Commit.create!(
      repository: repository,
      user: user,
      score: 1,
      created_at: Time.now - 5.months
    )

    CleanOldCommitsJob.perform_now

    assert_equal Commit.all, [commit_1, commit_2, commit_4]
  end
end
