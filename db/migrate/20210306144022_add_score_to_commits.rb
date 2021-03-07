class AddScoreToCommits < ActiveRecord::Migration[6.1]
  def change
    add_column :commits, :score, :integer, null: false, default: 0
  end
end
