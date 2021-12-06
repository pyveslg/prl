class AddKittIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :kitt_id, :integer
    batches = User.all.map{|x| x.batch}.uniq
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

#{"alumnus"=>{"id"=>12267, "first_name"=>"Pierre", "last_name"=>"BRIDE", "current_experience"=>{"picture"=>{"url"=>"//d26jy9fbi4q9wx.cloudfront.net/assets/company_placeholder-c8e19ec0f6ab43538d9b82ce6e897c681f2acf389f1f26a2c4646052d9968ee2.png", "avatar"=>{"url"=>"//d26jy9fbi4q9wx.cloudfront.net/assets/company_placeholder-c8e19ec0f6ab43538d9b82ce6e897c681f2acf389f1f26a2c4646052d9968ee2.png"}}, "url"=>nil, "position"=>"Locataire Gérant  at Carrefour City Évreux Jaurès"}, "avatar"=>"https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1625326723/liyji6t4euy6jtddjguz.jpg", "github"=>"pitbride", "alumni"=>true, "camp_slug"=>"660", "camp_date"=>"Jul '21", "city"=>"Paris", "engineering"=>false, "core"=>false, "teacher"=>true, "teaching_role"=>"TA", "since"=>"Oct '21"}}
#Pierre BRIDE created
