class KittService::GetUserListForABatch
  def initialize(batch_number:)
    @batch = batch_number
  end

  def call
    users_request = Kitt::AccessPoints::Users.new(search: @batch).call
    if users_request.success?
      users = {}
      users_request.data.dig('users').each do |user|
        users[user.dig('alumnus', 'id')] = OpenStruct.new(
          kitt_id: user.dig('alumnus', 'id'),
          first_name: user.dig('alumnus', 'first_name'),
          last_name: user.dig('alumnus', 'last_name'),
          github_nick: user.dig('alumnus', 'github')
        )
      end
      users
    else
      false
    end
  end
end
