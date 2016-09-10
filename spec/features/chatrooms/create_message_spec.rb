require 'rails_helper'

feature 'create' do
  let(:chatroom)         { FactoryGirl.create(:chatroom) }
  let(:message_text)     { Faker::Lorem.characters(15) }
  let(:user)             { FactoryGirl.create(:user, :is_anonymous) }

  scenario 'succesfully by unknown user' do
    visit '/'
    chatroom
    user
    visit chatrooms_path

    click_link chatroom.name
    expect(page).to have_content("Room name: #{chatroom.name}")

    fill_in 'message_content', with: message_text
    # click_button 'send'

    wait_for_ajax

    # expect(page).to have_selector('chatroom-card', text: message_text)
  end
end
