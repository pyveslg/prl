class Commit < ApplicationRecord
  belongs_to :user
  belongs_to :repository
  has_many :votes, dependent: :destroy

  scope :top, ->(*) { order(score: :desc) }
  scope :hot, ->(*) { joins('LEFT JOIN votes ON commits.id = votes.commit_id').order('votes.created_at') }
  scope :recent, ->(*) { order(created_at: :desc) }
  scope :random, ->(*) { }

  scope :upvoted, ->(session_id) { joins(:votes).where('votes.session_id = ?', session_id.to_s)}

  # didn't find a method to list scopes so don't forget to update this constant
  SCOPES = ['random', 'top', 'hot', 'recent', 'upvoted']
end
