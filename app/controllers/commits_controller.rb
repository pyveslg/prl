class CommitsController < ApplicationController

  def index
    @commits = Commit.all
  end
end
