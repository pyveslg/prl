class CommitsController < ApplicationController
  def index
    @total_count = Commit.count
    @batches = User.distinct.pluck(:batch).compact
    @usernames = usernames
    @pagy, commits = pagy(filtered_commits)
    @commits = commits.to_a
    @session_votes_by_commit_id = session_votes_by_commit_id(@commits)
  end

  private

  def filtered_commits
    commits = Commit.includes(:user).send(path).by_random

    if params[:batch].present?
      commits = commits.where(user: { batch: params[:batch] })
    end

    if params[:username].present?
      commits = commits.where(user: { github_username: params[:username] })
    end

    commits
  end

  def usernames
    User.order(:first_name, :last_name).map do |user|
      [user.full_name, user.github_username]
    end
  end

  def session_votes_by_commit_id(commits)
    Vote.where(session_id: session.id.to_s).where(commit: commits).to_h do |v|
      [v.commit_id, v]
    end
  end

  def path
    request.path == commits_path ? 'random' : request.path.delete('/')
  end
end
