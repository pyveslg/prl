require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "#full_name" do
    user = User.new(first_name: "Pierre-Thibaut", last_name: "Le Holl")

    assert_equal "Pierre-Thibaut L.", user.full_name
  end
end
