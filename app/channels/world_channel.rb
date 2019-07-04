# frozen_string_literal: true

class WorldChannel < ApplicationCable::Channel
  def subscribed
    pp 'WorldChannel'
    pp params

    stream_from "room-#{params['room']}:world"
  end

  def receive(payload)
    puts "receive"
    pp payload
    world_slug = params['room']
    chatroom = World.find_by(slug: world_slug)

    return nil

    bid_session = chatroom.bid_session
    return unless bid_session.open?

    # message or bid?

    params = {
      base_user_id: current_user.id,
      chatroom_id: chatroom.id,
      content: payload['message']
    }
    builder = Builders::MessageBuilder.new(params)
    if builder.save
      message = builder.message
      MessageBroadcastJob.perform_now(message)
    end
  end
end
