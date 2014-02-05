require 'spec_helper'

describe Game do
  auth = OmniAuth.config.mock_auth[:twitter]
  let(:user) {User.from_omniauth(auth)}

  it "has a winner" do
    game = Game.create

    game.users << user
    game.update_attributes(winner_id: user.id)
    game.save

    expect(game.winner).to eq user
  end

  it "has a loser" do
    game = Game.create
    user2 = User.create
    game.users << user
    game.update_attributes(winner_id: user2.id)

    expect(game.loser).to eq user
    expect(game.winner).not_to eq user
  end
end
