class AddValueToVote < ActiveRecord::Migration[6.1]
  def change
    add_column :votes, :value, :integer
  end
end
