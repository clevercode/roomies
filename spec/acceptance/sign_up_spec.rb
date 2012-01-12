require 'spec_helper'

feature 'Signing Up' do
  background do
    visit root_path
  end
  scenario 'A user not using oAuth', js: true do
    within '.sign-up-box' do
      fill_in 'user[email]', with: 'email@example.com'
      click_button 'Sign Up'
      fill_in 'user[password]', with: 'password123'
      click_button 'Sign Up'
    end
    current_path.should == corkboard_path
  end

  scenario 'A user generating a password', js: true do
    within '.sign-up-box' do
      fill_in 'user[email]', with: 'email@example.com'
      click_button 'Sign Up'
      click_link 'let us generate one for you'
    end
    page.should have_content('Password Generated')
    click_button "Okay, I've got it"
    click_button 'Sign Up'
    current_path.should == corkboard_path
  end

end
