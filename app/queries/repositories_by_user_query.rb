RepositoriesByUserQuery = GithubApi::Client.parse <<-'GRAPHQL'
  query($username: String!) {
    user(login: $username) {
      repositories(first: 50) {
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
