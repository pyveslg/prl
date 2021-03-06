module GithubApi::Discovery
  module_function

  def each_commit(username, repository, cursor = nil, &block)
    variables = { username: username, repository: repository, cursor: cursor }
    data = GithubApi::Client.query(CommitsByRepositoryQuery, variables: variables).data.to_h
    edges = data.dig("repository", "defaultBranchRef", "target", "history", "edges")

    return [] if !edges || edges.count == 0

    edges.each { |edge| block.call(edge["node"]) }

    each_commit(username, repository, edges.last["cursor"], &block)

    sleep 3
  end
end
