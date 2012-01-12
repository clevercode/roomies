require 'spec_helper'

feature 'Signing in' do
  background do
    visit root_path
  end

  #let(:user) { User.create!(email: 'test-user1@example.com', password: 'password123') }
  let(:user) { Factory.create(:user, password: 'password123') }

  scenario 'A user not using oAuth' do
    #user = User.create!(email: 'andrew@andrewesmith.com', password: 'password123') 
    click_link 'Sign In'
    within '.sign-in-box' do
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: 'password123'
      click_button "Let's Go"
    end
    page.should have_selector('.flash_notice')
    current_path.should == corkboard_path
    find('.flash_notice p').should have_content('Hey there, welcome back!')
  end

end
