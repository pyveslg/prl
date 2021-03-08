class Commit < ApplicationRecord
  belongs_to :user
  belongs_to :repository
  has_many :votes, dependent: :destroy
end
