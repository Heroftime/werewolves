require "test_helper"

class BattleTest < ActiveSupport::TestCase
  test "should not submit without initiator" do
    battle = Battle.new
    assert_not battle.save, "Attempted to submit battle without initiator"
  end
end
