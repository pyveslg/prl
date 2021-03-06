class CommitsController < ApplicationController

  def index
    @commits = filtered_commits
    @batches = User.distinct.pluck(:batch).compact
    @usernames = User.order(:first_name, :last_name).map do |user|
      [user.full_name, user.github_username]
    end
  end

  private

  def filtered_commits
    commits = Commit.joins(:user).by_random.limit(100)

    if params[:batch].present?
      commits = commits.where(user: { batch: params[:batch] })
    end

    if params[:username].present?
      commits = commits.where(user: { github_username: params[:username] })
    end

    commits
  end
end
