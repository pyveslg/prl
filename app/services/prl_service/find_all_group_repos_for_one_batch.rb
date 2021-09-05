class PrlService::FindAllGroupReposForOneBatch
  def initialize(batch_number:)
    @batch = batch_number
  end

  def call
    start_time = Time.now
    puts 'getting products..'
    products = KittService::GetBatchProductTeams.new(batch_number: @batch).call
    puts 'getting alumni..'
    alumni = KittService::GetUserListForABatch.new(batch_number: @batch).call
    puts 'getting github nicknames for each alumnus in each group..'
    github_groups = products.map{_1.teammates.map{|teammate| alumni[teammate['id']].github_nick}}
    puts 'getting repos for each github user & finding intersections..'
    github_groups.map{GithubService::FindCommonRepos.new(github_usernames: _1).call}
    puts "Done in #{(Time.now - start_time).round(2)} seconds (which is painfully slow)"
    github_groups
  end
end
