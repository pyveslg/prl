class Github::Api
  def each_commit(username, repository, cursor = nil, &block)
    variables = { username: username, repository: repository, cursor: cursor }
    data = query(COMMITS_BY_REPOSITORY_QUERY, variables: variables)

    edges = edges_from_data(data)
    return if !edges || edges.count == 0

    edges.each { |edge| block.call(edge[:node]) }

    each_commit(username, repository, edges.last[:cursor], &block)
  end

  class Error < RuntimeError
  end

  private

  def edges_from_data(data)
    data.dig(
      :data,
      :repository,
      :defaultBranchRef,
      :target,
      :history,
      :edges,
    )
  end

  GRAPHQL_URL = "https://api.github.com/graphql"

  COMMITS_BY_REPOSITORY_QUERY = <<~QUERY
    query($username: String!, $repository: String!, $cursor: String) {
      repository(owner: $username, name: $repository) {
        defaultBranchRef {
          target {
            ... on Commit {
              history(first: 100, after: $cursor) {
                edges {
                  cursor
                  node {
                    id
                    message
                    committedDate
                    author {
                      user {
                        login
                      }
                    }
                    committer {
                      email
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  QUERY

  def query(query, variables: {})
    RestClient.post(
      GRAPHQL_URL,
      { query: query, variables: variables }.to_json,
      Authorization: "Bearer #{ENV.fetch('GITHUB_ACCESS_TOKEN')}",
    ) do |response, _request, _result|
      json = JSON.parse(response, symbolize_names: true)

      raise Error, json[:message] if json[:message]

      json
    end
  end
end
