class ReplenishFoodCycle
  def initialize(world)
    @world = world
  end

  def run
    @world.each_empty_square do |empty_square|
      if will_receive_food?
        @world.add_to_grid(Food.create!(x: empty_square.x, y: empty_square.y))
      end
    end
    @world
  end

  private

  def will_receive_food?
    Food::CHANCE_OF_REPLENISHMENT > [*0..100].sample
  end
end