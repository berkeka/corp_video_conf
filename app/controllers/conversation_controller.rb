# frozen_string_literal: true

class ConversationController < ApplicationController
  before_action :authenticate_user!
  def index
    conversations = current_user.conversations
    render json: {
      status: { code: 200, message: 'Conversations listed.' },
      data: conversations
    }, status: :ok
  end

  def show; end

  def create
    convo = Conversation.new
    convo.users << current_user
    employee_users = User.where(role: 1)
    convo.users << employee_users.first unless employee_users.count.zero?
    if convo.save
      render json: {
        status: { code: 200, message: 'Conversation created succesfully.' },
        data: ConversationSerializer.new(convo).serializable_hash[:data][:attributes]
      }, status: :ok
    end
  end
end
