class GetAlumniJob < ApplicationJob
  queue_as :default

  def perform(batch)
    each_user(batch).each do |user|
      info = user[:alumnus]
      find_or_create_user(
        batch: batch,
        kitt_id: info[:id],
        first_name: info[:first_name],
        last_name: info[:last_name],
        github: info[:github],
      )
    end
  end

  private

  def each_user(batch)
    page = 1
    loop do
      data = get_kitt_users(batch: batch, page: page)
      data[:users].each do
        yield user
      end

      break unless data[:has_more]

      page += 1
    end
  end

  def get_kitt_users(batch:, page:)
    url = "https://kitt.lewagon.com/api/v1/users?search=#{batch}&page=#{page}"

    response = RestClient.get(url, cookie: cookie)
    JSON.parse(response.body, symbolize_names: true)
  end

  def cookie
    ENV.fetch("COOKIE")
  end

  def find_or_create_user(batch:, kitt_id:, first_name:, last_name:, github:)
    user = User.find_by(kitt_id: kitt_id)
    return if user

    user = User.find_by(email: "lewagonstudent#{kitt_id}@gmail.com")
    return user.update!(kitt_id: kitt_id) if user

    users.create!(
      email: "lewagonstudent#{kitt_id}@gmail.com",
      password: "123456",
      first_name: first_name,
      last_name: last_name,
      github_username: github,
      batch: batch,
      photo_url: "https://kitt.lewagon.com/placeholder/users/#{github}"
    )
  end
end
