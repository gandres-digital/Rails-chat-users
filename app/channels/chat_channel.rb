class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    puts "current_user: #{current_user}"
    if current_user.nil?
      puts "Error: current_user es nil en speak #{data}"
      return
    end
    ActionCable.server.broadcast("chat_#{params[:room]}", {
      user: current_user.email,
      message: data['message'],
      sent_at: Time.now
    })
  end
end 