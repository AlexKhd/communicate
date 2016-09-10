require 'rails_helper'

feature 'access rights' do

  scenario 'restricted to anon' do
    visit admin_root_path
    expect(page).to have_content('Access denied')
    expect(page).to have_current_path(root_path)

    visit admin_users_path
    expect(page).to have_content('Access denied')
    expect(page).to have_current_path(root_path)
  end
end
