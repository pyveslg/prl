class VotesController < ApplicationController
  def create
    @commit = Commit.find(vote_params[:commit_id])
    @vote = Vote.create_or_update_for_session_id(
      session_id: session.id,
      commit: @commit,
      value: vote_params[:value],
    )

    respond_to do |format|
      format.html { redirect_to commits_path }
      format.turbo_stream
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:commit_id, :value)
  end
end
