class ChatsController < ApplicationController
  require 'pusher'

  # POST /chats
  # POST /chats.json
  def create
    @chat = Chat.new(chat_params)
    @chat.user = current_user
    if @chat.save
      Pusher['global_chat_channel'].trigger('global_chat_event', {
        id: @chat.id,
        message: @chat.message,
        user: @chat.user.email,
        color: 'red',#@chat.user.color,
        created_at: @chat.user.created_at.strftime("%I:%M%p")
      })
    end

    render nothing: true
  end
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def chat_params
      params.require(:chat).permit(:message)
    end
end
