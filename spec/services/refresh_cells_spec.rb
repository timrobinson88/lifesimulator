require 'spec_helper'

describe RefreshCells do
  let(:world) { World.new(3,3) }
  let(:cell_1) { Cell.first }
  let(:cell_2) { Cell.find(2) }
  let(:cell_3) { Cell.find(3) }
  let(:cell_4) { Cell.find(4) }
  let(:cell_5) { Cell.find(5) }
  before do
    Cell.create(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 0, y: 0, has_mated: false, has_moved: false)
    Cell.create(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 0, y: 1, has_mated: true, has_moved: true)
    Cell.create(satiety: 8, propensity_to_move: 100, propensity_to_reproduce: 100, x: 1, y: 0, has_mated: false, has_moved: true)
    Cell.create(satiety: 1, propensity_to_move: 100, propensity_to_reproduce: 100, x: 1, y: 1, has_mated: true, has_moved: false)
    Cell.create(satiety: 0, propensity_to_move: 100, propensity_to_reproduce: 100, x: 2, y: 2, has_mated: false, has_moved: false)
    world.populate
    RefreshCells.new(world).run
  end

  it "should decrement each cells satiety by one" do
    expect(cell_1.satiety).to eq(9)
    expect(cell_2.satiety).to eq(9)
    expect(cell_3.satiety).to eq(7)
  end

  it "should set each cells has_moved attribute to false" do
    cells = Cell.all
    expect(cells.all? { |cell| cell.has_moved? == false }).to eq(true)
  end

  it "should set each cells has_mated attribute to false" do
    cells = Cell.all
    expect(cells.all? { |cell| cell.has_mated? == false }).to eq(true)
  end

  it "should destroy all cells with no remaining satiety" do
    expect(Cell.count).to eq(3)
  end
end