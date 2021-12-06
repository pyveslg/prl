class GetAlumniJob < ApplicationJob
  queue_as :default

  def perform(batch)
    url = "https://kitt.lewagon.com/api/v1/users?search=#{batch}"
    cookie = ENV.fetch("COOKIE")

    response = RestClient.get(url, cookie: cookie)
    response = JSON.parse(response.body)

    response["users"].each do |user|
      user_info = user["alumnus"]
      users = User.where(kitt_id: user_info["id"])
      next if users.any?

      if unid_user = User.find_by(email: "lewagonstudent#{user_info["id"]}@gmail.com")
        unid_user.update!(kitt_id: user_info["id"])
      else
        user = users.create!(
          email: "lewagonstudent#{user_info["id"]}@gmail.com",
          password: "123456",
          first_name: user_info["first_name"],
          last_name: user_info["last_name"],
          batch: batch,
          photo_url: "https://kitt.lewagon.com/placeholder/users/#{user_info["github"]}"
        )
      end

      puts "#{user.first_name} #{user.last_name} created"
    end
  end
end
