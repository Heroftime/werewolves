class HomeController < ApplicationController
  def index
  end

  def leaderboard
    @players = Battle.joins("INNER JOIN users ON battles.winner_id = users.id")
      .select("users.name, COUNT(battles.winner_id) as total_wins")
      .group("battles.winner_id")
      .order("total_wins DESC")
  end
end
