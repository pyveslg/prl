class AddDateToCommits < ActiveRecord::Migration[6.1]
  def change
    add_column :commits, :message_date, :date
  end
end
