require 'rails_helper'

feature 'access rights' do
  let(:user)   { create(:user) }

  scenario 'restricted to user' do
    login_as(user)
    visit admin_root_path
    expect(page).to have_content('Access denied')
    expect(page).to have_current_path(root_path)

    visit admin_users_path
    expect(page).to have_content('Access denied')
    expect(page).to have_current_path(root_path)
  end
end
