module Admin
  class HomeController < Admin::ApplicationController
    def index
      @users_count = User.count
      @chatrooms_count = Chatroom.count
      @messages_count = Message.count
      @chatrooms = Chatroom.all
    end
  end
end
