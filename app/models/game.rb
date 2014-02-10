class Game < ActiveRecord::Base
  has_many :players
  has_many :users, through: :players
  MAX_PLAYERS_PER_GAME = 2
  validate :games_can_only_have_max_players


  def winner
    User.find(winner_id)
  end

  def loser
    (users - [winner]).first
  end

  private
  def games_can_only_have_max_players
    if players.count > MAX_PLAYERS_PER_GAME
      errors.add(:players, "You have too many players")
    end
  end
end
