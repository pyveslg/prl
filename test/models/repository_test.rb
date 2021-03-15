require "test_helper"

class RepositoryTest < ActiveSupport::TestCase
  test "full_name returns both the GitHub handle and the name" do
    repository = Repository.new(github_username: "pyveslg", name: "prl")
    assert_equal "pyveslg/prl", repository.full_name
  end

  test ".matching_github_url finds repositories by splitting the name" do
    prl = Repository.create!(github_username: "pyveslg", name: "prl")
    not_prl = Repository.create!(github_username: "sunny", name: "prl")

    url = "https://github.com/pyveslg/prl"
    assert_equal [prl], Repository.matching_github_url(url).to_a
  end
end
