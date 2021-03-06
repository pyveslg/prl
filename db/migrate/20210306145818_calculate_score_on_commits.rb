class CalculateScoreOnCommits < ActiveRecord::Migration[6.1]
  class Vote < ActiveRecord::Base
  end

  class Commit < ActiveRecord::Base
    has_many :votes
  end

  def up
    say_with_time "Updating scores on #{Commit.count} commits" do
      Commit.find_each do |commit|
        commit.score = commit.votes.sum(:value)
      end
    end
  end

  def down; end
end
