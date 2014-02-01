require 'spec_helper'

describe "any user see users profile page" do
  it "can visit /username to see it" do
    auth = OmniAuth.config.mock_auth[:twitter]
    user = User.from_omniauth(auth)
    visit "/#{user.name}"
    expect(page).to have_content "#{user.name}"
  end
end
