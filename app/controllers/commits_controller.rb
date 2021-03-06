class CommitsController < ApplicationController

  def index
    if params[:query]
      @commits = Commit.joins(:user).where(user: {batch: params[:query]}).by_random.first(100)
    else
      @commits = Commit.by_random.first(100)
    end

    @commits = @commits.sort_by { |commit| commit.score }.reverse
  end
end
