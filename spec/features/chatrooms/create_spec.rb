require 'rails_helper'

feature 'create' do
  let(:user)          { create(:user) }
  let(:chatroom)      { create(:chatroom) }
  let(:room_name)     { Faker::Lorem.characters(15) }

  scenario 'succesfully by unknown user' do
    visit '/'
    chatroom
    visit chatrooms_path

    click_link chatroom.name
    expect(page).to have_content("Room name: #{chatroom.name}")

    visit chatrooms_path

    fill_in 'chatroom_name', with: room_name
    click_button 'Create'
    expect(page).to have_link(room_name)
  end

  scenario 'unsucc if name less than 6 sym' do
    visit '/'
    chatroom
    visit chatrooms_path

    fill_in 'chatroom_name', with: room_name.slice(0,4)
    click_button 'Create'
    expect(page).to have_content('Name of the room 6 symbols min!')
  end
end
