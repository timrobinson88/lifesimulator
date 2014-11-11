class FatherTime
  def run
    initial_world = World.new(20,20)
    initial_world.populate
    reproduced_world = ReproductionCycle.new(initial_world).run
    moved_world = MoveCycle.new(reproduced_world).run
    refreshed_world = RefreshCells.new(moved_world).run
    replenished_world = ReplenishFoodCycle.new(refreshed_world).run

    replenished_world
  end
end