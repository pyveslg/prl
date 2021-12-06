class AddKittIdToUsers < ActiveRecord::Migration[6.1]
  class User < ActiveRecord::Base
  end

  def change
    add_column :users, :kitt_id, :integer

    batches = User.distinct.pluck(:batch)
    cookie = ENV.fetch("COOKIE")
    batches.each do |batch|
      url = "https://kitt.lewagon.com/api/v1/users?search=#{batch}"

      response = RestClient.get(url, cookie: cookie)
      response = JSON.parse(response.body)

      response["users"].each do |user|
        user_info = user["alumnus"]
        users = User.where(github_username: user_info["github"])
        users = User.where(first_name: user_info["first_name"], last_name: user_info["last_name"]) unless users.any?
        users.first.update(kitt_id: user_info["id"]) if users.any?
        p "#{users.first.first_name} #{users.first.last_name} updated!" if users.any?
      end
    end
  end
end
