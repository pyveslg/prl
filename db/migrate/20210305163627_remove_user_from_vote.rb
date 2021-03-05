class RemoveUserFromVote < ActiveRecord::Migration[6.1]
  def change
    remove_column :votes, :user_id, :string
  end
end
