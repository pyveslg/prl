RepositoriesByUserQuery = GithubApi::Client.parse <<-'GRAPHQL'
  query($username: String!) {
    user(login: $username) {
      repositories(first: 100) {
        edges {
          cursor
          node {
            name
          }
        }
      }
    }
  }
GRAPHQL
