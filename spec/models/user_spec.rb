require 'spec_helper'

describe User do
  it "can create with omniauth" do
    expect(User.count).to eq 0
    auth = OmniAuth.config.mock_auth[:twitter]
    user = User.from_omniauth(auth)
    expect(User.count).to eq 1
    expect(user.provider).to eq auth["provider"]
    expect(user.name).to eq auth["info"]["nickname"]
    expect(user.avatar_url).to eq auth["info"]["image"]
    expect(user.access_token).to eq auth["credentials"]["token"]
    expect(user.access_secret).to eq auth["credentials"]["secret"]
  end

  it "updates new data" do
    auth = OmniAuth.config.mock_auth[:twitter]
    user = User.from_omniauth(auth)
    old_token = user.access_token
    old_secret =user.access_secret
    auth["credentials"]["token"] = "token"
    auth["credentials"]["secret"] = "secret"
    new_user = User.from_omniauth(auth)
    expect(new_user.id).to eq user.id
    expect(new_user.access_token).not_to eq old_token
    expect(new_user.access_secret).not_to eq old_secret
  end

  it "has many games" do
    auth = OmniAuth.config.mock_auth[:twitter]
    user = User.from_omniauth(auth)
    game = Game.create

    game.users << user

    expect(game.users).to include user
    expect(user.games).to include game
  end

  it "has wins and losses" do
    auth = OmniAuth.config.mock_auth[:twitter]
    user = User.from_omniauth(auth)
    game = Game.create

    game.users << user
    game.update_attributes(winner_id: user.id)
    game.save

    game2 = Game.create
    game2.users << user

    game3 = Game.create
    game3.users << user

    expect(user.games.count).to eq 3
    expect(user.wins).to include game
    expect(user.wins.count).to eq 1
    expect(user.losses).not_to include game
    expect(user.losses.count).to eq 2
  end

  it "can interface with external clients" do
    auth = OmniAuth.config.mock_auth[:twitter]
    user = User.from_omniauth(auth)
    client = user.messaging_client
    expect(client.class).to eq MessagingClient
    expect(client.user).to eq user
  end

  it "can invite another user to  game" do
    auth = OmniAuth.config.mock_auth[:twitter]
    user = User.from_omniauth(auth)
    game = Game.new
    game.users << user
    user.invite(game: game, user: user2)
  end

end
