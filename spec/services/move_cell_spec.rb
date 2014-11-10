require "spec_helper"

describe MoveCell do
  let(:world) { World.new(3,3) }
  let(:empty_square) { world.item_at(0, 1) }
  let(:cell) { Cell.last }
  let(:food) { Food.last }

  describe "moving a cell on to a square containing food" do
    before do
      Cell.create!(satiety: 4, propensity_to_move: 100, propensity_to_reproduce: 100, x: 0, y:0, has_mated: false)
      Food.create!(x: 1, y: 0)
      world.populate
      MoveCell.new(cell, food, world).move
    end
    it "updates the previous location of the cell to be an empty square" do
      expect(world.item_at(0,0).class).to eq(EmptySquare)
    end

    it "updates the cell coordinates to that of the destination square" do
      expect([cell.x, cell.y]).to eq([1, 0])
    end

    it "maps the cells new location to the world grid" do
      expect(world.item_at(1, 0)).to eq(cell)
    end

    it "replenishes the cells satiety" do
      expect(cell.satiety).to eq(10)
    end

    it "destroys the Food in the destination square" do
      expect(Food.count).to eq(0)
    end
  end

  describe "moving a cell on to an empty square" do
    before do
      Cell.create!(satiety: 4, propensity_to_move: 100, propensity_to_reproduce: 100, x: 0, y:0, has_mated: false)
      Food.create!(x: 1, y: 0)
      world.populate
      MoveCell.new(cell, empty_square, world).move
    end

    it "decreases the cells satiety by two" do
      expect(cell.satiety).to eq(2)
    end

    it "updates the previous location of the cell to be an empty square" do
      expect(world.item_at(0,0).class).to eq(EmptySquare)
    end
    
    it "updates the cell coordinates to that of the destination square" do
      expect([cell.x, cell.y]).to eq([0, 1])
    end
  end
end