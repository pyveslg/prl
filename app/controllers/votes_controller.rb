class VotesController < ApplicationController
  def create
    commit = Commit.find(vote_params[:commit_id])
    vote = Vote.create_or_update_for_session_id(
      session_id: session.id,
      commit: commit,
      value: vote_params[:value],
    )

    broadcast_score_replace(commit)

    respond_to do |format|
      format.turbo_stream { render turbo_stream: commit_replace(commit, vote) }
      format.html { redirect_to commits_path }
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:commit_id, :value)
  end

  def broadcast_score_replace(commit)
    Turbo::StreamsChannel.broadcast_replace_to(
      "scores",
      target: "score-#{commit.id}",
      partial: "commits/score",
      locals: { commit: commit },
    )
  end

  def commit_replace(commit, vote)
    turbo_stream.replace(
      commit,
      partial: "commits/commit",
      locals: { commit: commit, vote: vote },
    )
  end
end
