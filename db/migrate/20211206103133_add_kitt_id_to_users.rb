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
        user = User.find_by(github_username: user_info["github"])
        user = User.find_by(first_name: user_info["first_name"], last_name: user_info["last_name"]) unless user
        user.update!(kitt_id: user_info["id"]) if user
        puts "#{user.first_name} #{user.last_name} updated!" if user
      end
    end
  end
end
