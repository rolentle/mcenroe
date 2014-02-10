class User < ActiveRecord::Base
  has_many :players
  has_many :games, through: :players

  def self.from_omniauth(auth)
    user = User.find_or_create_by(
      uid:      auth["uid"]
    )
    user.update_attributes(
      name:          auth["info"]["nickname"],
      provider: auth["provider"],
      avatar_url:    auth["info"]["image"],
      access_token:  auth["credentials"]["token"],
      access_secret: auth["credentials"]["secret"]
    )
    user
  end

  def wins
    games.where(winner_id: id)
  end

  def losses
    games - wins
  end

  def messaging_client
    MessagingClient.new(self)
  end
end
