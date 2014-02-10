require 'spec_helper'

describe Game do
  auth = OmniAuth.config.mock_auth[:twitter]
  let(:user) {User.from_omniauth(auth)}

  it "has a winner" do
    game = Game.create

    game.users << user
    game.winner = user

    expect(game.winner).to eq user
  end

  it "has a loser" do
    game = Game.create
    user2 = User.create
    game.users << user
    game.users << user2
    game.winner = user2

    expect(game.loser).to eq user
    expect(game.winner).not_to eq user
  end

  it "can only have two players" do
    game = Game.create
    user2 = User.create
    user3 = User.create
    game.users << user
    game.users << user2
    game.should be_valid

    game.users << user3
    game.should_not be_valid
  end
end
