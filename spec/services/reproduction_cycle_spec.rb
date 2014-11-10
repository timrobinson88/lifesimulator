require "spec_helper"

describe ReproductionCycle do

  before do 
    Cell.create!(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 1, y:0, has_mated: false, has_moved: false)
    Cell.create!(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 0, y:0, has_mated: false, has_moved: false)
    Cell.create!(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 0, y:1, has_mated: false, has_moved: false)
    Cell.create!(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 1, y:1, has_mated: false, has_moved: false)
  end

  describe "Running the Reproduction Cycle" do
    before do
      srand 123
      rc = ReproductionCycle.new
      rc.run
    end

    describe "the effect on cells" do
      it "should mark all cells that have reproduced as having mated" do
        cells = Cell.all
        expect(cells.all? { |cell| cell.has_mated? }).to eq(true)
      end

      it "should produce the correct number of new cells" do
        expect(Cell.count).to eq(6)
      end

      it "should position newly created cells in the appropriate positions" do
        cell = Cell.last 
        expect([cell.x, cell.y]).to eq([1,2])
      end

      it "newly created cells should be unable to mate immediately" do
        expect(Cell.last(2).all? {|cell| cell.has_mated? }).to eq(true)
      end
    end
  end
end