class AddFirstNameToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :github_username, :string
    add_column :users, :batch, :string
  end
end
