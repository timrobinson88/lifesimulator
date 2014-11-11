require "spec_helper"

describe CreateOffspring do
  let(:cell_1) { Cell.new(satiety: 10, propensity_to_move: 68, propensity_to_reproduce: 50, x: 1, y:0, has_mated: false) }
  let(:cell_2) { Cell.new(satiety: 10, propensity_to_move: 74, propensity_to_reproduce: 40, x: 0, y:0, has_mated: false) }
  let(:birth_place) { EmptySquare.new(0, 1) }
  let(:create_offspring) { CreateOffspring.new(cell_1, cell_2, birth_place) }

  describe "Making a new offspring" do
    before { srand 767 }

    let(:offspring) { create_offspring.make! }

    it "assigns the offspring a propensity to move that inherits from a parent with a genetic variation applied" do
      expect(offspring.propensity_to_move).to eq(64)
    end

    it "assigns the offspring a propensity to reproduce that inherits from a parent with a genetic variation applied" do
      expect(offspring.propensity_to_reproduce).to eq(43)
    end

    it "produces offspring with maximum satiety" do
      expect(offspring.satiety).to eq(Cell::MAXIMUM_SATIETY)
    end

    it "assigns the offspring the location of the specified birth place" do
      expect([offspring.x, offspring.y]).to eq([0,1])
    end

    it "should make offspring unable to mate immediately" do
      expect(offspring.has_mated).to eq(true)
    end
  end
end