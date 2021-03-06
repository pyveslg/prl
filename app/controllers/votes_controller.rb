class VotesController < ApplicationController
  def vote
    commit = Commit.find(params[:commit_id])
    Vote.create(commit: commit, value: params[:vote].to_i)

    score = commit.votes.sum(:value)
    commit.update!(score: score)

    render json: score
  end
end
