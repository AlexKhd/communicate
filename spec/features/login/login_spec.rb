require 'rails_helper'

feature 'user login' do
  let(:user)   { create(:user) }

  scenario 'with invalid user data' do
    visit '/users/sign_in'

    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password')
  end

  scenario 'with correct data' do
    visit '/users/sign_in'

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    find('input[type="submit"]').click

    visit '/'
    expect(page).to have_link 'Logout'
  end
end
