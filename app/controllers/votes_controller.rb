class VotesController < ApplicationController

  # def create
  #   commit = Commit.find(params[:commit_id])
  #   Vote.create(commit: commit, user: current_user)
  #   redirect_back(fallback_location: root_path)
  #   #change to render as json to fetch from JS, maybe with updated total votes on commit
  # end

  # def delete
  #   commit = Commit.find(params[:commit_id])
  #   Vote.find_by(user: current_user, commit: commit).destroy
  #   redirect_back(fallback_location: root_path)
  #   #change to render as json to fetch from JS, maybe with updated total votes on commit
  # end

  def vote
    commit = Commit.find(params[:commit_id])
    Vote.create(commit: commit, value: params[:vote].to_i)
    render json: commit.votes.sum(:value)
  end

end
