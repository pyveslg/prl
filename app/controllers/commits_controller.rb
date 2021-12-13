class CommitsController < ApplicationController
  def index
    @batches =
      User.distinct.where.not(batch: nil).order(batch: :desc).pluck(:batch)
    @users = filtered_users
    @pagy, commits = pagy(filtered_commits)
    @commits = commits.to_a
    @session_votes_by_commit_id = session_votes_by_commit_id(@commits)
  end

  protected

  def current_scope
    params[:scope] if Commit::SCOPES.include?(params[:scope])
  end
  helper_method :current_scope

  def current_batch_code
    params[:batch] if @batches.include?(params[:batch])
  end
  helper_method :current_batch_code

  private

  def filtered_users
    return if current_batch_code.nil?

    User.joins(:commits).where(batch: current_batch_code).by_name.distinct
  end

  def filtered_commits
    commits = Commit.includes(:user).public_send(current_scope, *scope_arguments)
    if current_batch_code
      commits = commits.where(user: { batch: current_batch_code })
    end

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

  def scope_arguments
    [session.id.to_s] if current_scope == "voted"
  end
end
