require "test_helper"

class CleanUselessCommitsJobTest < ActiveJob::TestCase
  test "#perform" do
    repository = Repository.create!(name: "test", github_username: "test")
    user = User.create!

    commit_1 = Commit.create!(
      repository: repository,
      user: user,
      message: "Ok",
    )

    commit_2 = Commit.create!(
      repository: repository,
      user: user,
      message: "Merge branch origin/master",
    )

    CleanUselessCommitsJob.perform_now

    assert_equal Commit.all, [commit_1]
  end
end
