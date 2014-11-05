class ReproductionCycle
  def run
    @world = World.new(3,3).populate

    @world.each_square do |cell|
      attempt_to_reproduce(cell) if cell.able_to_reproduce?
    end

    @world.persist_grid
  end

  def attempt_to_reproduce(cell)
    produce_offspring!(cell) if mating_conditions_are_favourble?(cell)
  end

  def mating_conditions_are_favourble(cell)
    @world.has_empty_neighbouring_squares?(cell) && has_available_mate?(cell)
  end

  def cells_available_to_mate_with(cell)
    @world.neighbouring_cells(cell).select { |potential_mate| potential_mate.is_available_to_reproduce? }
  end

  def has_available_mate?(cell)
    cells_available_to_mate_with(cell).length > 0
  end

  def produce_offspring!(cell)
    mate = cells_available_to_mate_with(cell).sample
    parents = [cell, mate]
    parent_to_inherit_from = parents.sample
    birth_place = empty_neighbouring_squares(cell).sample

    offspring = Cell.create!(x: birth_place.x, y: birth_place.y, satiety: 10, propensity_to_reproduce: offspring_propensity_to_reproduce(parent_to_inherit_from), propensity_to_move: offspring_propensity_to_move(parent_to_inherit_from), has_mated: true)
    
    parents.each { |parent| parent.has_mated = true }

    insert_offspring_into_grid(offspring)
  end 

  def insert_offspring_into_grid(offspring)
    @world.map_to_grid(offspring)
  end

  def genetic_variation
    [*-10..10].sample
  end

  def offspring_propensity_to_reproduce(parent)
    offspring_propensity_to_reproduce = parent.propensity_to_reproduce + genetic_variation
    offspring_propensity_to_reproduce = 0 if offspring_propensity_to_reproduce < 0
    offspring_propensity_to_reproduce = 100 if offspring_propensity_to_reproduce > 100

    offspring_propensity_to_reproduce
  end

  def offspring_propensity_to_move(parent)
    offspring_propensity_to_move = propensity_to_move + genetic_variation
    offspring_propensity_to_move = 100 if offspring_propensity_to_move >= 100
    offspring_propensity_to_move = 0 if offspring_propensity_to_move <= 0

    offspring_propensity_to_move
  end

  def has_empty_neighbouring_squares?(cell)
    @world.empty_neighbouring_squares(cell).count > 0
  end
end

