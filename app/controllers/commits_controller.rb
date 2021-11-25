class CommitsController < ApplicationController
  def index
    @batch = params[:batch] || User.maximum(:batch)
    @batches =
      User.distinct.where.not(batch: nil).order(batch: :desc).pluck(:batch)
    @users = User.where(batch: @batch).order(:first_name, :last_name)
    @pagy, commits = pagy(filtered_commits)
    @commits = commits.to_a
    @session_votes_by_commit_id = session_votes_by_commit_id(@commits)
  end

  protected

  def current_scope
    params[:scope] if Commit::SCOPES.include?(params[:scope])
  end
  helper_method :current_scope

  private

  def filtered_commits
    commits = Commit.includes(:user).public_send(current_scope, *scope_arguments)
    commits = commits.where(user: { batch: @batch })

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
    [session.id] if scope == "voted"
  end
end
