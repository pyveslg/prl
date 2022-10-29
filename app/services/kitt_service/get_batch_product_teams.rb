class KittService::GetBatchProductTeams
  def initialize(batch_number:)
    @batch_number = batch_number
  end

  def call
    products_page_request = Kitt::AccessPoints::Products.new(batch_number: @batch_number).call
    if products_page_request.success?
      parse_and_return_groups_from(products_page_request)
    else
      false
    end
  end

  def parse_and_return_groups_from(products_page_request)
    groups = products_page_request.data.dig('team_ready_products').map do |group|
      OpenStruct.new(
        id: group.dig('id'),
        name: group.dig('name'),
        teammates: group.dig('teammates').unshift(group.dig('product_owner')).map{_1.except('avatar_url')}
      )
    end
  end
end
