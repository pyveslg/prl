class CommitsController < ApplicationController
  def index
    @batches =
      User.distinct.where.not(batch: nil).order(batch: :desc).pluck(:batch)
    if batch
      @users = User.where(batch: batch).order(:first_name, :last_name)
    end

    @pagy, commits = pagy(filtered_commits)
    @commits = commits.to_a
    @session_votes_by_commit_id = session_votes_by_commit_id(@commits)
  end

  private

  def filtered_commits
    commits = Commit.includes(:user).public_send(scope, session.id)
    commits = commits.where(user: { batch: batch }) if batch

    if params[:username].present?
      commits = commits.where(user: { github_username: params[:username] })
    end

    commits
  end

  def session_votes_by_commit_id(commits)
    Vote.where(session_id: session.id.to_s).where(commit: commits).to_h do |v|
      [v.commit_id, v]
    end
  end

  def scope
    params[:scope] if Commit::SCOPES.include?(params[:scope])
  end

  # Returns nil when the batch param is set to an empty string (all batches).
  def batch
    if @batches.include?(params[:batch])
      params[:batch]
    elsif params[:batch].nil?
      @batches.first
    end
  end
end
