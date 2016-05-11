class MessagesController < ApplicationController
  before_action :get_conversation
  before_action :set_prep

  def index
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end
    if @messages.last && @messages.last.user_id != current_user.id
      @messages.last.read = true
    end
    @message = @conversation.messages.new
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      redirect_to prep_conversation_messages_path(prep_id: @prep.id, conversation_id: @conversation.id)
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id)
  end

  def get_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

end
