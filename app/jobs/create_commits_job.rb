class CreateCommitsJob < ApplicationJob
  queue_as :default

  def perform(user)
    @user = user
    login = user.github_username

    url = "http://api.github.com/search/commits?page=1&per_page=100&q=author:#{login}"

    response = RestClient.get(url, headers = { "Accept" => "application/vnd.github.cloak-preview" })
    response =  JSON.parse(response.body)

    total_commits = response["total_count"]

    response['items'].each do |item|
      next if item['committer']['email'] == "noreply@github.com"
      user.update(email: item['commit']['committer']['email'])
      break
    end

    create_commits_from(response['items'])


    (2..total_commits.fdiv(100).ceil).to_a.each do |page|
      sleep(5)
      url = "http://api.github.com/search/commits?page=#{page}&per_page=100&q=author:#{login}"

      response = RestClient.get(url, headers = { "Accept" => "application/vnd.github.cloak-preview" })
      response =  JSON.parse(response.body)

      puts response['items'].size

      create_commits_from(response['items'])
    end


    puts 'done'

  end

  def create_commits_from(items)
    items.each do |item|
      commit = item['commit']
      next if Commit.find_by(github_id: item["node_id"])
      next if commit['committer']['email'] == "noreply@github.com"
      puts commit['message']
      Commit.create!(
        user: @user,
        github_id: item["node_id"],
        message: commit["message"],
        message_date: commit["author"]["date"]
      )
    end
  end
end
