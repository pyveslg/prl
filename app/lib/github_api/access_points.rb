class GithubApi::AccessPoints
  def call
    response = RestClient.get(@url)
    if response && response.code == 200
      data = JSON.parse(response.body)
      return result = OpenStruct.new(success?: true, data: data)
    else
      return result = OpenStruct.new(success?: false, result: response)
    end
  end
end
