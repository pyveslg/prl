class Vote < ApplicationRecord
  belongs_to :commit

  validates :value, presence: true, inclusion: { in: [1, -1] }
end
