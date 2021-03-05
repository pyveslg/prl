class VotesController < ApplicationController

  def create
    commit = Commit.find(params[:commit_id])
    Vote.create(commit: commit, user: current_user)
  end

end
