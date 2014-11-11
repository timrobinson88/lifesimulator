class ReproductionCycle
  def initialize(world)
    @world = world
  end
  
  def run
    @world.each_cell do |cell|
      offspring = cell.attempt_to_reproduce(cells_available_to_mate_with(cell), occupiable_neighbouring_squares(cell))
   
      insert_offspring_into_grid(offspring) if offspring != nil   
    end

    @world.persist_grid
    @world
  end

  private

  def cells_available_to_mate_with(cell)
    @world.neighbouring_cells(cell).select { |potential_mate| potential_mate.wants_to_reproduce?}
  end

  def occupiable_neighbouring_squares(cell)
    @world.occupiable_neighbouring_squares(cell)
  end

  def insert_offspring_into_grid(offspring)
    @world.add_to_grid(offspring)
  end
end

