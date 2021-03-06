class CreateRepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :repositories do |t|
      t.string :github_username, null: false
      t.string :name, null: false
      t.timestamps
      t.index %i[github_username name]
    end
  end
end
