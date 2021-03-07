class Commit < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy

  def vote_by(session_id)
    vote = votes.find_by(session_id: session_id)
    vote.value == 1 ? 'upvote' : 'downvote' unless vote.nil?
  end
end
