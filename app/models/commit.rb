class Commit < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy

  def upvoted_by?(session_id)
    Vote.find_by(commit: self, value: 1, session_id: session_id).present?
  end

  def downvoted_by?(session_id)
    Vote.find_by(commit: self, value: -1, session_id: session_id).present?
  end

  def voted_by?(session_id)
    downvoted_by?(session_id) || upvoted_by?(session_id)
  end

  def vote_by?(session_id)
    'downvote' if downvoted_by?(session_id)
    'upvote' if upvoted_by?(session_id)
    'novote' unless voted_by?(session_id)
  end
end
