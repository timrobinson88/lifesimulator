require 'spec_helper'

describe SalmonellaOutbreak do
  before do
    Cell.create!(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 1, y:0, has_mated: false, has_moved: false)
    Cell.create!(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 0, y:0, has_mated: false, has_moved: false)
    Cell.create!(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 0, y:1, has_mated: false, has_moved: false)
    Cell.create!(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 1, y:1, has_mated: false, has_moved: false)
    Food.create!(x: 2, y:2)
    Food.create!(x: 2, y:1)
    SalmonellaOutbreak.new.run
  end

  it "should destroy all Cells" do
    expect(Cell.count).to eq(0)
  end

  it "should destroy all Food" do
    expect(Food.count).to eq(0)
  end
end