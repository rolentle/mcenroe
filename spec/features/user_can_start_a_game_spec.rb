require 'spec_helper'

describe "user can start a game" do
  it "a user can start a game" do
    login
    click_on "Start a Game"
    expect(page).to have_content "Invite an Opponent"
  end

end
