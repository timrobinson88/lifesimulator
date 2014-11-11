require 'spec_helper'

describe CreateInitialPopulation do
  before do
    srand 234
    CreateInitialPopulation.new.run
  end

  it "creates four cells" do
    expect(Cell.count).to eq(4)
  end

  it "creates two cells in the top right hand side" do
    expect(Cell.where(x: 10...20, y: 0...10).length).to eq(2)
  end

  it "creates two cells in the bottom left hand side" do
    expect(Cell.where(x: 0...10, y: 10...20).length).to eq(2)
  end

  it "creates an initial population of Food" do
    expect(Food.count).to eq(68)
  end
end