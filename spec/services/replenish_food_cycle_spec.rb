require "spec_helper"

describe ReplenishFoodCycle do
  before do 
    Cell.create(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 0, y: 0, has_mated: false, has_moved: true)
    Cell.create(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 0, y: 1, has_mated: false, has_moved: true)
    Cell.create(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 1, y: 0, has_mated: false, has_moved: true)
    Food.create(x: 1, y: 1)
    world = World.new(3, 3)
    world.populate
    srand 1237
    ReplenishFoodCycle.new(world).run
  end

  describe "running the food replenishment cycle" do
    it "does not generate food on squares occupied by cells" do
      expect(Food.where(x: 0, y: 0)).to eq([])
      expect(Food.where(x: 0, y: 1)).to eq([])
      expect(Food.where(x: 1, y: 0)).to eq([])
    end 

    it "randomly generates food in empty squares" do
      expect(Food.count).to eq(3)
    end
  end
end