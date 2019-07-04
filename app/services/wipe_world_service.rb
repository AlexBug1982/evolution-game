class WipeWorldService

  def initialize
  end

  def call
    World.all.destroy_all
  end
end
