# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


batch = 551

url = "https://kitt.lewagon.com/api/v1/users?search=#{batch}"

cookie = ENV['COOKIE']

response = RestClient.get(url, headers = { cookie: cookie })

response =  JSON.parse(response.body)
# puts response["page_count"]

response["users"].each do |user|
  user_info = user["alumnus"]
  unless User.find_by(github_username: user_info["github"])
    u = User.create(email: "lewagonstudent#{user_info["id"]}@gmail.com", password: "123456", first_name: user_info["first_name"], last_name: user_info["last_name"], github_username: user_info["github"], batch: batch)
    puts "#{u.first_name} #{u.last_name} created"
  end
end
