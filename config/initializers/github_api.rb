require "graphql/client"
require "graphql/client/http"

module GithubApi
  GITHUB_ACCESS_TOKEN = ENV.fetch("GITHUB_ACCESS_TOKEN")
  URL = "https://api.github.com/graphql"

  HttpAdapter = GraphQL::Client::HTTP.new(URL) do
    def headers(context)
      {
        "Authorization" => "Bearer #{GITHUB_ACCESS_TOKEN}",
        "User-Agent" => "Ruby",
      }
    end
  end

  Schema = GraphQL::Client.load_schema(HttpAdapter)
  Client = GraphQL::Client.new(schema: Schema, execute: HttpAdapter)
end
