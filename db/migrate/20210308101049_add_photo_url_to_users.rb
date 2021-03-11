class AddPhotoUrlToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :photo_url, :string
    User.update_all("photo_url = CONCAT('https://kitt.lewagon.com/placeholder/users/', github_username)")
  end
end
