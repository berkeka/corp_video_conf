# frozen_string_literal: true

class RoomChannel < ApplicationCable::Channel
  # calls when a client connects to the server
  def subscribed
    if params[:room_id].present?
      # creates a private chat room with a unique name
      stream_from("ChatRoom-#{params[:room_id]}")
    end
  end

  # calls when a client broadcasts data
  def speak(data)
    sender    = get_sender(data['sender'])
    room_id   = data['room_id']
    message   = data['message']

    raise 'No room_id!' if room_id.blank?

    convo = get_convo(room_id)

    raise 'No conversation found!' if convo.blank?
    raise 'No message!' if message.blank?

    # adds the message sender to the conversation if not already included
    convo.users << sender unless convo.users.include?(sender)
    # saves the message and its data to the DB
    # Note: this does not broadcast to the clients yet!
    Message.create!(
      conversation: convo,
      user_id: sender.id,
      content: message
    )
  end

  def get_convo(room_code)
    Conversation.find_by(id: room_code)
  end

  def get_sender(id)
    User.find_by(id: id)
  end
end