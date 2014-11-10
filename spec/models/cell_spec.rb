require 'spec_helper'

describe Cell do
  let(:cell) { Cell.new(x: 0, y:1, satiety: 8, propensity_to_reproduce: 100, propensity_to_move: 100, has_mated: false) }
  let(:empty_squares) { [EmptySquare.new(0,0), EmptySquare.new(1,0)] }
  let(:mates) { [Cell.new(x: 0, y:2, satiety: 8, propensity_to_reproduce: 100, propensity_to_move: 100, has_mated: false), Cell.new(x: 1, y:1, satiety: 8, propensity_to_reproduce: 100, propensity_to_move: 100, has_mated: false)]}
  let(:world) { World.new(3,3) }


  describe "Attempting to reproduce" do
    it "is not be able to mate if it has already done so and not been refreshed" do
      cell.mate
      expect(cell.attempt_to_reproduce(mates, empty_squares)).to eq(nil)
    end

    it "produces an offspring when the cell is available to reproduce and there are available mates and empty_squares" do
      expect(cell.attempt_to_reproduce(mates, empty_squares).class).to eq(Cell)
    end

    it "does not produce offspring if there are no occupiable neighbouring squares" do
      expect(cell.attempt_to_reproduce(mates, [])).to eq(nil)
    end

    it "does not produce offspring if there are no available mates" do
      expect(cell.attempt_to_reproduce([], empty_squares)).to eq(nil)
    end

    it "does not produce offspring if the cell does not want to reproduce" do
      cell.propensity_to_reproduce = 0
      expect(cell.attempt_to_reproduce(mates, empty_squares)).to eq(nil)
    end
  end

  describe "Attempting to move" do
    it "does not move if there are no occupiable neighbouring squares" do
      cell.attempt_to_move([], world)
      expect([cell.x, cell.y]).to eq([0,1])
    end

    it "changes its position if there are occupiable neighbouring squares" do
      cell.attempt_to_move([EmptySquare.new(0, 0)], world)
      expect([cell.x, cell.y]).to eq([0, 0])
    end

    it "can move to a square containing food" do
      food = Food.create!(x: 0, y: 0)
      world.populate
      cell.attempt_to_move([food], world)
      expect([cell.x, cell.y]).to eq([0,0])
    end
  end
end