class RefreshCells
  def initialize(world)
    @world = world
  end

  def run
    @world.each_cell do |cell|
      cell.satiety -= 1

      if cell.satiety < 1
        DestroyCell.new(cell, @world).destroy
      else
        cell.has_mated = false
        cell.has_moved = false
      end
    end

    @world.persist_grid
    @world
  end
end