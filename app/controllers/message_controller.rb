class MessageController < ApplicationController
  before_action :authenticate_user!
  respond_to :json
  
  # TODO Fix this ugliness
  def show
    convo = Conversation.find(params['id'])

    render json: convo.messages, status: :ok if convo
  end
end
