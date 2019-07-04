class AddNewPlayerJob < ApplicationJob
  queue_as :default

  def perform(player)
    world = player.world
    payload = {
      player_color: player.color,
      cell_pos_x: player.cells.first.pos_x,
      cell_pos_y: player.cells.first.pos_y
    }
    ActionCable.server.broadcast "room-#{world.slug}:world", type: 'new_player', payload: payload
  end
end
