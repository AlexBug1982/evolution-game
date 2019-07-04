class ResetWorldService

  def initialize
  end

  def call
    Cell.all.destroy_all
    Player.all.each do |player|
      service = CellServices::Persist::Creator.new(player)
      service.call
    end
  end
end
