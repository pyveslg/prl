class VotesController < ApplicationController
  def create
    @commit = Commit.find(vote_params[:commit_id])
    @vote = create_vote(
      commit: @commit,
      value: vote_params[:value].to_i,
      session_id: session.id.to_s,
    )

    respond_to do |format|
      format.html { redirect_to commits_path }
      format.turbo_stream
    end
  end

  private

  def create_vote(commit:, value:, session_id:)
    votes = Vote.where(commit: commit, session_id: session_id)
    votes.destroy_all
    vote = votes.create!(value: value) unless value == 0

    commit.update_column(:score, commit.votes.sum(:value))

    vote
  end

  def vote_params
    params.require(:vote).permit(:commit_id, :value)
  end
end
