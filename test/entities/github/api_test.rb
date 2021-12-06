require "test_helper"

class Github::ApiTest < ActiveJob::TestCase
  test "#each_commit calls GitHub and loops around commits" do
    api = Github::Api.new
    username = "testuser"
    repository = "testrepo"

    mock_commit = {
      committer: {
        email: "email@example.com",
      },
      id: 1234,
      author: {
        user: {
          login: "someuser",
        },
      },
      message: "some commit message",
      committedDate: "2018-01-01T00:00:00Z",
    }

    mock_body_1 = {
      data: {
        repository: {
          defaultBranchRef: {
            target: {
              history: {
                edges: [
                  {
                    node: mock_commit,
                    cursor: "z1",
                  },
                ],
              },
            },
          },
        },
      },
    }

    mock_body_2 = {
      data: {
        repository: {
          defaultBranchRef: {
            target: {
              history: {
                edges: [],
              },
            },
          },
        },
      },
    }

    expected_request_1_body = {
      query: Github::Api::COMMITS_BY_REPOSITORY_QUERY,
      variables: {
        username: "testuser",
        repository: "testrepo",
        cursor: nil,
      },
    }

    expected_request_2_body = {
      query: Github::Api::COMMITS_BY_REPOSITORY_QUERY,
      variables: {
        username: "testuser",
        repository: "testrepo",
        cursor: "z1",
      },
    }

    stub_request(:post, "https://api.github.com/graphql")
      .with(body: expected_request_1_body.to_json)
      .to_return(status: 200, body: mock_body_1.to_json)

    stub_request(:post, "https://api.github.com/graphql")
      .with(body: expected_request_2_body.to_json)
      .to_return(status: 200, body: mock_body_2.to_json)

    commits = []

    api.each_commit(username, repository) do |commit|
      commits << commit
    end

    assert_equal [mock_commit], commits
  end
end
