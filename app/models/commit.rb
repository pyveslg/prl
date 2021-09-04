class Commit < ApplicationRecord
  belongs_to :user
  belongs_to :repository
  has_many :votes, dependent: :destroy

  # Scopes that are publicly available (path => scope name)
  SCOPES = %w[
    top
    random
    hot
    recent
    voted
  ]

  scope :top, ->(_session_id) { order(score: :desc) }
  scope :random, ->(_session_id) { by_random }
  scope :hot, ->(_session_id) {
    left_joins(:votes).order(Vote.arel_table[:created_at])
  }
  scope :recent, ->(_session_id) { order(created_at: :desc) }
  scope :voted, ->(session_id) {
    joins(:votes).where(votes: { session_id: session_id.to_s }).hot
  }
end
