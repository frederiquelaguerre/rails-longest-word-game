require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get controller" do
    get games_controller_url
    assert_response :success
  end
end
