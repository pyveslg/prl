class AddIdToCommits < ActiveRecord::Migration[6.1]
  def change
    add_column :commits, :github_id, :string
  end
end
