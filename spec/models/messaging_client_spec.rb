require 'spec_helper'

describe MessagingClient do
  it "has a user" do
    auth = OmniAuth.config.mock_auth[:twitter]
    user = User.from_omniauth(auth)

    messaging_client = MessagingClient.new(user)
    expect(messaging_client.user).to eq user
  end
end
