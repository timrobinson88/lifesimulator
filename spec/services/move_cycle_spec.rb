require 'spec_helper'

describe MoveCycle do
  let(:world) { World.new(3, 3) }
  let(:move_cycle) { MoveCycle.new(world) }
  let(:first_cell) { Cell.first }
  let(:second_cell) { Cell.find(2) }
  let(:third_cell) { Cell.find(3) }
  let(:fourth_cell) { Cell.find(4) }

  before do
    Cell.create(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 0, y: 0, has_mated: false, has_moved: false)
    Cell.create(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 1, y: 0, has_mated: false, has_moved: false)
    Cell.create(satiety: 10, propensity_to_move: 0, propensity_to_reproduce: 100, x: 2, y: 0, has_mated: false, has_moved: false)
    Cell.create(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 2, y: 2, has_mated: false, has_moved: true)
  end

  describe "running the move cycle" do
    before do
      srand 12345
      world.populate
      MoveCycle.new(world).run
    end

    it "should move all of the eligible cells to new locations" do
      expect([first_cell.x, first_cell.y]).to eq([1,1])
      expect([second_cell.x, second_cell.y]).to eq([0,1])
      expect([third_cell.x, third_cell.y]).to eq([2,0])
      expect([fourth_cell.x, fourth_cell.y]).to eq([2,2])
    end
  end


end