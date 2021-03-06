class Repository < ApplicationRecord
  has_many :commits, dependent: :destroy

  validates :name, presence: true
  validates :github_username, presence: true

  def full_name
    "#{github_username}/#{name}"
  end
end
