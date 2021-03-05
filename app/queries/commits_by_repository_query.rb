CommitsByRepositoryQuery = GithubApi::Client.parse <<-'GRAPHQL'
  query($username: String!, $repository: String!, $cursor: String) {
    repository(owner: $username, name: $repository) {
      defaultBranchRef {
        target {
          ... on Commit {
            history(first: 5, after: $cursor) {
              edges {
                cursor
                node {
                  id
                  message
                  author {
                    name
                    date
                    user {
                      login
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
GRAPHQL
