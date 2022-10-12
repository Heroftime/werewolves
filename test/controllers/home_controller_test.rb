require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in(@user)
  end

  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "should get leaderboard" do
    get leaderboard_url
    assert_response :success
  end
end
