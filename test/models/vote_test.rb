require "test_helper"

class VoteTest < ActiveSupport::TestCase

  test "create_or_update_for_session_id creates an upvote" do
    user = User.create!(email: "acme@example.com", password: "acme@example.com")
    repository = Repository.create!(github_username: "acme", name: "acme")
    commit = Commit.create!(user: user, repository: repository)
    previous_vote = Vote.create!(session_id: "abc", commit: commit, value: 1)
    commit.update(score: commit.votes.sum(:value))

    vote = Vote.create_or_update_for_session_id(
      session_id: "efg",
      commit: commit,
      value: 1,
    )

    assert_equal [previous_vote, vote], commit.votes
    assert_equal 2, commit.reload.score
  end

  test "create_or_update_for_session_id creates a downvote" do
    user = User.create!(email: "acme@example.com", password: "acme@example.com")
    repository = Repository.create!(github_username: "acme", name: "acme")
    commit = Commit.create!(user: user, repository: repository)
    previous_vote = Vote.create!(session_id: "abc", commit: commit, value: 1)
    commit.update(score: commit.votes.sum(:value))

    vote = Vote.create_or_update_for_session_id(
      session_id: "efg",
      commit: commit,
      value: -1,
    )

    assert_equal [previous_vote, vote], commit.votes
    assert_equal 0, commit.reload.score
  end

  test "create_or_update_for_session_id replaces any previous session vote" do
    user = User.create!(email: "acme@example.com", password: "acme@example.com")
    repository = Repository.create!(github_username: "acme", name: "acme")
    commit = Commit.create!(user: user, repository: repository)
    previous_vote = Vote.create!(session_id: "abc", commit: commit, value: 1)
    commit.update(score: commit.votes.sum(:value))

    vote = Vote.create_or_update_for_session_id(
      session_id: "abc",
      commit: commit,
      value: -1,
    )

    assert_equal [vote], commit.votes
    assert_equal -1, commit.reload.score
  end

  test "create_or_update_for_session_id with 0 removes a previous vote" do
    user = User.create!(email: "acme@example.com", password: "acme@example.com")
    repository = Repository.create!(github_username: "acme", name: "acme")
    commit = Commit.create!(user: user, repository: repository)
    previous_vote = Vote.create!(session_id: "abc", commit: commit, value: 1)
    commit.update(score: commit.votes.sum(:value))

    vote = Vote.create_or_update_for_session_id(
      session_id: "abc",
      commit: commit,
      value: 0,
    )

    assert_equal [], commit.votes
    assert_equal 0, commit.reload.score
  end

  test "create_or_update_for_session_id still works after destroying votes" do
    user = User.create!(email: "acme@example.com", password: "acme@example.com")
    repository = Repository.create!(github_username: "acme", name: "acme")
    commit = Commit.create!(user: user, repository: repository)
    previous_vote = Vote.create!(session_id: "abc", commit: commit, value: 1)
    previous_vote = Vote.create!(session_id: "def", commit: commit, value: 1)
    previous_vote = Vote.create!(session_id: "ghi", commit: commit, value: 1)
    commit.update(score: commit.votes.sum(:value))

    commit.votes.destroy_all

    vote = Vote.create_or_update_for_session_id(
      session_id: "mno",
      commit: commit,
      value: 1,
    )

    assert_equal [vote], commit.votes
    assert_equal 4, commit.reload.score
  end
end
