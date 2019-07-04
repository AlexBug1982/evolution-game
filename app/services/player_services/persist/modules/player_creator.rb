# frozen_string_literal: true

module PlayerServices::Persist::Modules::PlayerCreator
  attr_reader :player

  def create_player
    player_name = create_params[:player_name]
    existing_player = Player.find_by(player_name: player_name)
    if existing_player.present?
      add_new_error('player_name', 'already registered')
    end # existing_player.present?
    return unless valid?

    if create_params[:color].blank?
      add_new_error('color', 'missing')
    end # existing_player.present?
    return unless valid?

    if create_params[:color].size < 7
      add_new_error('color', 'wrong format')
    end # existing_player.present?
    return unless valid?

    if create_params[:color].first != '#'
      add_new_error('color', 'wrong format')
    end # existing_player.present?
    return unless valid?

    player_params = {
      player_name: create_params[:player_name],
      color: create_params[:color],
      world: World.first
    }

    @player = Player.new
    @player.assign_attributes(player_params)
    if @player.valid?
      @player.save
      @player.reload
      create_first_cell(@player)
      @player.cells.reload
    else
      add_new_error('player_name', 'missing')
    end
  end

  def create_first_cell(player)
    service = CellServices::Persist::Creator.new(player)
    service.call
  end
end
