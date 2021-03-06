class AddIndexes < ActiveRecord::Migration[6.1]
  def change
    add_index :commits, :github_id
    add_index :users, :github_username
    add_index :users, :batch
  end
end
