CommitsByRepositoryQuery = GithubApi::Client.parse <<-'GRAPHQL'
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
GRAPHQL
