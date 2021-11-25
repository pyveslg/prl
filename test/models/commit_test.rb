require "test_helper"

class CommitTest < ActiveSupport::TestCase
  test "top scope sorts by score" do
    repository = Repository.create!(name: "test", github_username: "test")
    user = User.create!
    a = Commit.create!(score: 10, repository: repository, user: user)
    b = Commit.create!(score: 5, repository: repository, user: user)
    c = Commit.create!(score: 50, repository: repository, user: user)

    assert_equal Commit.top.to_a, [c, a, b]
  end

  test "random scope sorts by random" do
    repository = Repository.create!(name: "test", github_username: "test")
    user = User.create!
    a = Commit.create!(score: 10, repository: repository, user: user)
    b = Commit.create!(score: 5, repository: repository, user: user)
    c = Commit.create!(score: 50, repository: repository, user: user)

    assert_equal Commit.random.sort_by(&:id), [a, b, c]
  end

  test "hot scope sorts by recent votes first" do
    repository = Repository.create!(name: "test", github_username: "test")
    user = User.create!
    a = Commit.create!(repository: repository, user: user)
    b = Commit.create!(repository: repository, user: user)
    c = Commit.create!(repository: repository, user: user)

    Vote.create!(value: 1, commit: c, created_at: 1.day.ago)
    Vote.create!(value: 1, commit: a, created_at: 2.days.ago)

    assert_equal Commit.hot.to_a, [c, a]
  end

  test "recent scope sorts by creation date" do
    repository = Repository.create!(name: "test", github_username: "test")
    user = User.create!
    a =
      Commit.create!(repository: repository, user: user, created_at: 2.days.ago)
    b =
      Commit.create!(repository: repository, user: user, created_at: 3.days.ago)
    c =
      Commit.create!(repository: repository, user: user, created_at: 1.day.ago)

    assert_equal Commit.recent.to_a, [c, a, b]
  end

  test "voted scope filters only the current voter" do
    repository = Repository.create!(name: "test", github_username: "test")
    user = User.create!
    a =
      Commit.create!(repository: repository, user: user, created_at: 2.days.ago)
    b =
      Commit.create!(repository: repository, user: user, created_at: 3.days.ago)
    c =
      Commit.create!(repository: repository, user: user, created_at: 1.day.ago)

    Vote.create!(value: 1, commit: c, session_id: "42", created_at: 1.day.ago)
    Vote.create!(value: 1, commit: a, session_id: "42", created_at: 2.days.ago)

    assert_equal Commit.voted("42").to_a, [c, a]
  end
end
