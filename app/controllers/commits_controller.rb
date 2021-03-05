class CommitsController < ApplicationController

  def index
    if params[:query]
      @commits = Commit.joins(:user).where(user: {batch: params[:query]}).by_random
    else
      @commits = Commit.by_random
    end
  end
end
