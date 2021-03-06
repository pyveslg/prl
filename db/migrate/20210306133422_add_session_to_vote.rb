class AddSessionToVote < ActiveRecord::Migration[6.1]
  def change
    add_column :votes, :session_id, :string
  end
end
