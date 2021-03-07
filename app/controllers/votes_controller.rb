class VotesController < ApplicationController
  def vote
    commit = Commit.find(params[:commit_id])

    votes = Vote.where(commit: commit, session_id: session.id.to_s)
    votes.destroy_all
    vote = votes.create!(value: params[:value]) unless params[:value] == "0"

    commit.update_column(:score, commit.votes.sum(:value))

    render json: {
      votes: commit.score,
      content: render_to_string(
        partial: "shared/vote",
        locals: { commit: commit, vote: vote },
        layout: false,
      )
     }
  end
end
