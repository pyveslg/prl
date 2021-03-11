class Commit < ApplicationRecord
  belongs_to :user
  belongs_to :repository
  has_many :votes, dependent: :destroy

  scope :top, ->(*) { order(score: :desc) }
  scope :hot, ->(*) { joins('LEFT JOIN votes ON commits.id = votes.commit_id').order('votes.created_at') }
  scope :recent, ->(*) { order(created_at: :desc) }
  scope :random, ->(*) { all }

  scope :voted, ->(session_id) { joins(:votes).where('votes.session_id = ?', session_id.to_s).hot}

  # didn't find a method to list scopes so don't forget to update this constant
  SCOPES = ['random', 'top', 'hot', 'recent', 'voted']
end
