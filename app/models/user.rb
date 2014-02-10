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
    players.where(winner: true).map(&:game)
  end

  def losses
    players.where(winner: false).map(&:game)
  end

  def messaging_client
    MessagingClient.new(self)
  end

  def invite(options ={})
    game = options[:game]
    if options[:user].class == String
       user = User.find_or_create_by(name: options[:user])
    else
      user = options[:user]
    end
    game.users << user
  end
end
