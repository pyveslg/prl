class Commit < ApplicationRecord
  belongs_to :user
  belongs_to :repository
  has_many :votes, dependent: :destroy

  scope :top, ->(*) { order(score: :desc) }
  scope :hot, ->(*) { left_joins(:votes).order(Vote.arel_table[:created_at]) }
  scope :recent, ->(*) { order(created_at: :desc) }
  scope :random, ->(*) { by_random }

  scope :voted, ->(session_id) { joins(:votes).where('votes.session_id = ?', session_id.to_s).hot}

  # didn't find a method to list scopes so don't forget to update this constant
  SCOPES = {
    'commits' => 'random',
    'random' => 'random',
    'top' => 'top',
    'hot' => 'hot',
    'recent' => 'recent',
    'voted' => 'voted'
  }
end
