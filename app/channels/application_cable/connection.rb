# frozen_string_literal: true

# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_player

    def connect
      self.current_player = find_verified_player
    end

    protected

    def find_verified_player
      current_player = Player.find_by_id(cookies[:player_id])
      if current_player.present?
        current_player
      else
        reject_unauthorized_connection
      end
    end
  end
end
