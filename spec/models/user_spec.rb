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
end
