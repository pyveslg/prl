class Commit < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy

  def upvoted_by?(session_id)
    votes.where(value: 1, session_id: session_id).any?
  end

  def downvoted_by?(session_id)
    votes.where(value: -1, session_id: session_id).any?
  end

  def voted_by?(session_id)
    downvoted_by?(session_id) || upvoted_by?(session_id)
  end
end
