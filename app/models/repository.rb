class Repository < ApplicationRecord
  has_many :commits, dependent: :destroy

  validates :name, presence: true
  validates :github_username, presence: true

  def self.matching_github_url(url)
    match = %r{https://github.com/(.*?)/(.*)}.match(url)
    return none unless match

    where(github_username: match[1], name: match[2])
  end

  def full_name
    "#{github_username}/#{name}"
  end
end
