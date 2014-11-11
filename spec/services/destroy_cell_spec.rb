require 'spec_helper'

describe DestroyCell do
  describe "destroying a cell" do
    let(:world) { World.new(3, 3) }

    before do
      cell = Cell.create(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 0, y: 0, has_mated: false, has_moved: false)
      world.populate
      DestroyCell.new(cell, world).destroy
    end

    it "destroys the cell" do
      expect(Cell.count).to eq(0)
    end

    it "replace the cell with an empty square on the grid" do
      expect(world.item_at(0, 0)).to eq(EmptySquare.new(0, 0))
    end
  end
end