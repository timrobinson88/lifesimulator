class PrepareCellsForMating
  def initialize
    @world = World.new(3,3)
    @world.populate
  end

  def run
    @world.each_cell { |cell| cell.has_mated = false }
    @world.persist_grid

    @world
  end
end