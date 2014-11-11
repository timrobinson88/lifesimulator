class CreateInitialPopulation
  def initialize
    @world = World.new(20,20)
  end
  def run
    generate_first_cell
    generate_second_cell
    generate_third_cell
    generate_fourth_cell
    @world.populate
    ReplenishFoodCycle.new(@world).run
  end

  private

  def generate_first_cell
    x = [*10...20].sample
    y = [*0...10].sample
    @first_cell = Cell.create!(x: x, y: y, satiety: Cell::MAXIMUM_SATIETY, propensity_to_reproduce: random_propensity, propensity_to_move: random_propensity, has_mated: false, has_moved: false)
  end

  def generate_second_cell
    x = [*10...20].sample
    if x == @first_cell.x
      y_possibilities = [*0...10] - [@first_cell.y]
      y = y_possibilities.sample
    else
      y = [*0...10].sample
    end

    Cell.create!(x: x, y: y, satiety: Cell::MAXIMUM_SATIETY, propensity_to_reproduce: random_propensity, propensity_to_move: random_propensity, has_mated: false, has_moved: false)
  end

  def generate_third_cell
    x = [*0...10].sample
    y = [*10...20].sample
    @third_cell = Cell.create!(x: x, y: y, satiety: Cell::MAXIMUM_SATIETY, propensity_to_reproduce: random_propensity, propensity_to_move: random_propensity, has_mated: false, has_moved: false)
  end

  def generate_fourth_cell
    x = [*0...10].sample
    if x == @third_cell.x
      y_possibilities = [*10...20] - [@third_cell.y]
      y = y_possibilities.sample
    else
      y = [*10...20].sample
    end

    Cell.create!(x: x, y: y, satiety: Cell::MAXIMUM_SATIETY, propensity_to_reproduce: random_propensity, propensity_to_move: random_propensity, has_mated: false, has_moved: false)
  end

  def random_propensity
    [*30..80].sample
  end
end

