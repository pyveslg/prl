class Kitt::AccessPoints
  def call
    cookie = ENV.fetch("COOKIE")

    response = RestClient.get(@url, headers = { cookie: cookie })
    if response && response.code == 200
      data = JSON.parse(response.body)
      return result = OpenStruct.new(success?: true, data: data)
    else
      return result = OpenStruct.new(success?: false, result: response)
    end
  end
end
