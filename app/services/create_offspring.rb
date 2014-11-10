class CreateOffspring
  def initialize(parent_1, parent_2, birth_place)
    @parent_1 = parent_1
    @parent_2 = parent_2
    @parent_to_inherit_from = select_parent_to_inherit_from
    @birth_place = birth_place
  end

  def make!
    offspring = Cell.create!(x: @birth_place.x, y: @birth_place.y, satiety: Cell::MAXIMUM_SATIETY, propensity_to_reproduce: offspring_propensity_to_reproduce(@parent_to_inherit_from), propensity_to_move: offspring_propensity_to_move(@parent_to_inherit_from), has_mated: true)
    
    @parent_1.mate
    @parent_2.mate

    offspring
  end

  private

  def select_parent_to_inherit_from
    [@parent_1, @parent_2].sample
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
    offspring_propensity_to_move = parent.propensity_to_move + genetic_variation
    offspring_propensity_to_move = 100 if offspring_propensity_to_move >= 100
    offspring_propensity_to_move = 0 if offspring_propensity_to_move <= 0

    offspring_propensity_to_move
  end
end