# frozen_string_literal: true

module PlayerServices::Session::Runtime
  class PlayerFinder

    attr_reader :player_id, :error, :player

    def initialize(player_id)
      @player_id = player_id
    end

    def call
      unless player_id.present?
        create_session_error('invalid_token')
        return
      end
      player = Player.find_by(id: player_id)
      unless player.present?
        create_session_error('player_not_found')
        return
      end
      @player = player
    end

    def create_session_error(session_error)
      @error = 'session_errors.' + session_error
    end

    def current_player
      @player
    end
  end
end
