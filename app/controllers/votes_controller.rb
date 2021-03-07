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
    votes = Vote.where(commit: commit, session_id: session.id)
    votes.destroy_all
    votes.create!(value: params[:value]) unless params[:value] == "0"
    # render json: commit.votes.sum(:value)
    render json: {
       votes: commit.votes.sum(:value),
       content: (render_to_string partial: "shared/vote", locals: {commit: commit}, layout: false )
     }
    # rendre une partial pour le vote en question
  end

end
