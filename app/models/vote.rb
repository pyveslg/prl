class Vote < ApplicationRecord
  belongs_to :commit

  validates :value, presence: true, inclusion: { in: [1, -1] }

  def self.create_or_update_for_session_id(session_id:, commit:, value:)
    transaction do
      votes = commit.votes.where(session_id: session_id)
      votes.destroy_all

      vote = votes.create!(value: value) unless value.to_i == 0

      commit.update_column(:score, commit.votes.sum(:value))

      vote
    end
  end
end
