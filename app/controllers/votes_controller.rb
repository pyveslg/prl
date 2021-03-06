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
    # Vote.find_or_create_by(commit: commit, value: params[:vote].to_i, session_id: session.id.to_s)
    vote_params = {commit: commit, value: params[:value].to_i, session_id: session.id.to_s}
    Vote.where(vote_params.except(:value)).destroy_all
    Vote.create(vote_params) unless params[:value] == '0'
    # render json: commit.votes.sum(:value)
    render json: {
       votes: commit.votes.sum(:value),
       content: (render_to_string partial: "shared/vote", locals: {commit: commit}, layout: false )
     }
    # rendre une partial pour le vote en question
  end

end
