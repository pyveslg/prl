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

  scope :top, -> { order(score: :desc) }
  scope :random, -> { by_random }
  scope :hot, -> { joins(:votes).order(Vote.arel_table[:created_at].desc) }
  scope :recent, -> { order(created_at: :desc) }
  scope :voted, -> session_id { hot.where(votes: { session_id: session_id }) }
end
