class Game < ActiveRecord::Base
  has_many :players
  has_many :users, through: :players


  def winner
    User.find(winner_id)
  end

  def loser
    (users - [winner]).first
  end
end
