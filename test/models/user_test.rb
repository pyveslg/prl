require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "full_name returns the first name and a shortened last name" do
    user = User.new(first_name: "Pierre-Thibaut", last_name: "Le Holl")

    assert_equal "Pierre-Thibaut L.", user.full_name
  end

  test "full_name returns the first name only when there is no last name" do
    user = User.new(first_name: "Pierre-Thibaut", last_name: "")

    assert_equal "Pierre-Thibaut", user.full_name
  end
end
