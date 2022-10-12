require "test_helper"

class BattlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @battle = battles(:one)
    @user = users(:one)
    sign_in(@user)
  end

  test "should get index" do
    get battles_url
    assert_response :success
  end

  test "should get new" do
    get new_battle_url
    assert_response :success
  end

  test "should create battle" do
    assert_difference("Battle.count") do
      post battles_url, params: { battle: { initiator_id: @battle.initiator_id, opponent_id: @battle.opponent_id, status: @battle.status, winner_id: @battle.winner_id } }
    end

    assert_redirected_to battle_url(Battle.last)
  end

  test "should show battle" do
    get battle_url(@battle)
    assert_response :success
  end

  test "should get edit" do
    get edit_battle_url(@battle)
    assert_response :success
  end

  test "should update battle" do
    patch battle_url(@battle), params: { battle: { initiator_id: @battle.initiator_id, opponent_id: @battle.opponent_id, status: @battle.status, winner_id: @battle.winner_id } }
    assert_redirected_to battle_url(@battle)
  end
end
