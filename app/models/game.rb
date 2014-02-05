class Game < ActiveRecord::Base
  has_many :players
  has_many :users, through: :players
  has_one :winner, class_name: "User" do
    def find_by_winner(winner_id)
      User.find(winner_id)
    end
  end

  def winner=(user)
    winner_id = user.id
  end
end
