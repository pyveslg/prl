require "test_helper"

class CommitsControllerTest < ActionController::TestCase
  test "/voted succeeds" do
    get :index, params: { scope: "voted" }

    assert_response :success
  end
end
