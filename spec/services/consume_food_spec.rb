require "spec_helper"

describe ConsumeFood do
  let(:food_square) { Food.create!(x: 0, y: 1) }
  let(:cell) { Cell.create!(satiety: 4, propensity_to_move: 100, propensity_to_reproduce: 100, x: 0, y:0, has_mated: false) }

  before do
    ConsumeFood.new(cell, food_square).consume
  end

  it "replenishes the cell satiety to full" do
    expect(cell.satiety).to eq(10)
  end

  it "destroys the food cell" do
    expect(Food.count).to eq(0)
  end
end