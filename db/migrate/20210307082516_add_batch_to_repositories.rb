class AddBatchToRepositories < ActiveRecord::Migration[6.1]
  def change
    add_column :repositories, :batch, :string
  end
end
