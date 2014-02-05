module Helpers
  def login
    visit root_path
    click_on "Sign in with Twitter"
  end
end
