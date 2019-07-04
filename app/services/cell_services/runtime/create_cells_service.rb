module CellServices::Runtime
  class CreateCellsService
    def initialize
    end

    def call
      worlds = World.all
      worlds.each do |world|
        players = world.players.shuffle
        players.each do |player|
          player_cells_amount = player.cells.size
          cell_creation_turns = [1, (player_cells_amount / 5).round].max

          current_cell_creation_turn = 0
          while current_cell_creation_turn < cell_creation_turns  do
            service = CellServices::Persist::Creator.new(player)
            service.call
            if service.new_cell.present?
              payload = {
                player_color: player.color,
                player_name: player.player_name,
                cell_pos_x: service.new_cell.pos_x,
                cell_pos_y: service.new_cell.pos_y
              }
              ActionCable.server.broadcast "room-#{world.slug}:world", type: 'new_cell', payload: payload
            end
            current_cell_creation_turn +=1
          end
        end
      end
    end
  end
end
