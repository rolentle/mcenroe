require 'spec_helper'
 describe 'I can Sign in with Twitter' do
   it "logins in when I click on the button and then logout" do
     visit root_path
     click_on "Sign in with Twitter"
     expect(page).to have_content "Sign Out"
     click_on "Sign Out"
     expect(page).to have_content "Sign in with Twitter"
   end
 end
