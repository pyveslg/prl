class Batch
  include ActiveModel::Model
  attr_accessor :number, :repository_urls

  def initialize(number: nil, repository_urls: nil)
    @number = number
    @repository_urls = repository_urls.is_a?(String) ? repository_urls.split : repository_urls
  end
end
