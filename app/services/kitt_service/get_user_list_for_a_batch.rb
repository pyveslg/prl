class KittService::GetUserListForABatch
  def initialize(batch:)
    @batch = batch
  end

  def call
    users_request = Kitt::AccessPoints::Users.new(search: @batch).call
    if users_request.success?
      users = users_request.data.dig('users').map do |user|
        OpenStruct.new(
          kitt_id: user.dig('alumnus', 'id'),
          first_name: user.dig('alumnus', 'first_name'),
          last_name: user.dig('alumnus', 'last_name'),
          github_nick: user.dig('alumnus', 'github')
        )
      end
    else
      false
    end
  end
end
