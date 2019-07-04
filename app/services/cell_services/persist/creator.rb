# frozen_string_literal: true

module CellServices::Persist
  class Creator
    include BooleanHelper
    include ActiveRecordErrorParser

    attr_reader :player, :world, :new_cell
    attr_accessor :errors

    def initialize(player)
      @player = player
      @world = player.world
      puts 'CellServices::Persist:Creator.init'
      p "player.world_id: " + player.world_id.to_s
      p "world.width: " + world.width.to_s
      p "world.height: " + world.height.to_s
    end

    def call
      @errors = ActiveModel::Errors.new(self)

      if player.cells.size.zero?
        create_first_cell
      else
        create_new_cells
      end
    end

    def valid?
      errors.empty?
    end

    private

    def create_first_cell
      random_x = rand(0..world.width)
      random_y = rand(0..world.height)
      @new_cell = Cell.create!(player: player, world: world, pos_x: random_x, pos_y: random_y)
      @new_cell.reload
    end

    def create_new_cells
      @new_cell = get_random_cell_from_player
    end

    def get_random_cell_from_player
      puts "get_random_cell_from_player"
      player_cells = player.cells.shuffle
      near_by_cell = nil
      player_cells.each do |player_cell|
        puts 'Player_cell: ' + player_cell.id.to_s
        break if near_by_cell.present?
        near_by_cell = get_near_by_cell(player_cell)
      end
      near_by_cell
    end

    OTHERS_POS = [[-1,-1],[0,-1],[1,-1],[-1,0],[1,0],[-1,1],[0,1],[1,1]]
    def get_near_by_cell(player_cell)
      puts "get_near_by_cell"
      pos_x = player_cell.pos_x
      pos_y = player_cell.pos_y
      found_new_cell = nil
      OTHERS_POS.shuffle.each do |other_pos|
        break if found_new_cell.present?
        other_cell_pos_x = pos_x + other_pos.first
        puts 'other_cell_pos_x: ' + other_cell_pos_x.to_s
        next if other_cell_pos_x >= world.width
        next if other_cell_pos_x < 0
        other_cell_pos_y = pos_y + other_pos.second
        puts 'other_cell_pos_y: ' + other_cell_pos_y.to_s
        next if other_cell_pos_y >= world.height
        next if other_cell_pos_y < 0
        other_cell = Cell.find_by(world: world, pos_x: other_cell_pos_x, pos_y: other_cell_pos_y)
        if other_cell.present? && other_cell.player != player
          puts "Found other cell from enemy"
          puts 'Other_cell: ' + other_cell.id.to_s
          found_new_cell = do_cell_battle(player_cell, other_cell)
        elsif other_cell.blank?
          puts 'No other cell found'
          found_new_cell = Cell.create!(player: player, world: world, pos_x: other_cell_pos_x, pos_y: other_cell_pos_y)
          found_new_cell.reload
        end
      end
      puts 'found_new_cell'
      p found_new_cell
      found_new_cell
    end

    def do_cell_battle(player_cell, other_cell)
      player_strength = player_cell.player.color.to_i(16) % 16
      other_strength = other_cell.player.color.to_i(16) % 16
      if player_strength >= other_strength
        other_cell
      else
        nil
      end
    end

    def add_new_error(key, error)
      errors.add(key.to_sym, error)
    end
  end
end
