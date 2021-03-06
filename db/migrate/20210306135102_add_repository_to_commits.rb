class AddRepositoryToCommits < ActiveRecord::Migration[6.1]
  def change
    add_reference :commits, :repository, foreign_key: true
  end
end
