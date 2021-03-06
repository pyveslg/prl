class CommitsController < ApplicationController

  def index
    if params[:query]
      @commits = Commit.joins(:user).where(user: { batch: params[:query] })
    else
      @commits = Commit.all
    end

    @commits = @commits.order(score: :desc).by_random.limit(100)
  end
end
