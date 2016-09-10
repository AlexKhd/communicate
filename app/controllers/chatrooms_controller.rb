class ChatroomsController < ApplicationController
  before_action :create_anonymous

  def index
    @chatroom = Chatroom.new
    @chatrooms = Chatroom.all
  end

  def show
    @chatroom = Chatroom.friendly.find(params[:id])
    @message = Message.new
  end

  def new
    if request.referrer.split('/').last == 'chatrooms'
      flash[:notice] = nil
    end
    @chatroom = Chatroom.new
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      respond_to do |format|
        format.html { redirect_to @chatroom }
        format.js
      end
    else
      respond_to do |format|
        flash[:notice] = {error: ['error while creating the chatroom!']}
        format.html { redirect_to new_chatroom_path }
        format.js { render template: 'chatrooms/chatroom_error.js.erb'}
      end
    end
  end

  private
    def chatroom_params
      params.require(:chatroom).permit(:name)
    end

    def create_anonymous
      email = Rails.application.secrets.an_email
      pwd = Rails.application.secrets.an_pwd
      User.create!(name: :anonymous, email: email, password: pwd) unless User.find_by_name(:anonymous)
    end
end
