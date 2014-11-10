require "spec_helper"

describe World do
  let(:world) { World.new(4,4) }
  let(:cell) { Cell.first }
  let(:fourth_cell) { Cell.find(4) } 


  before do 
    Cell.create!(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 1, y:0, has_mated: false, has_moved: false)
    Cell.create!(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 0, y:0, has_mated: false, has_moved: false)
    Cell.create!(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 0, y:1, has_mated: false, has_moved: false)
    Cell.create!(satiety: 10, propensity_to_move: 100, propensity_to_reproduce: 100, x: 1, y:1, has_mated: false, has_moved: false)
    Food.create!(x: 3, y: 3)
    Food.create!(x: 2, y: 2)
  end

  it "is initialized containing empty squares in each square" do
    empty_squares = 0
    world.each_square {|square| empty_squares += 1 if square.class == EmptySquare }
    expect(empty_squares).to eq(16)
  end

  describe "populating the world" do
    before do
      world.populate
      @cells = 0
      @empty_squares = 0
      @food = 0
      world.each_square do |square| if square.class == EmptySquare
          @empty_squares += 1
        elsif square.class == Cell
          @cells += 1
        elsif square.class == Food
          @food += 1
        else
        end
      end
    end

    it "loads all cells into its grid when populated" do
      expect(@cells).to eq(4)
    end

    it "loads all food items into its grid when populated" do
      expect(@food).to eq(2)
    end

    it "maintains the empty_squares where cells do not exist" do
      expect(@empty_squares).to eq(10)
    end
  end

  describe "once the world is populated" do
    before { world.populate }

    it "maps cells to the correct square" do
      grid = world.instance_variable_get(:@grid)
      expect(grid[0][1]).to eq(cell)
      expect(grid[1][1]).to eq(fourth_cell)
    end

    it "is able to find the squares surrounding a given cell" do
      expect(world.neighbouring_squares(cell).length).to eq(5)
      expect(world.neighbouring_squares(fourth_cell).length).to eq(8)
    end

    it "can find the squares containing cells around a given cell" do
      expect(world.neighbouring_cells(cell).length).to eq(3)
      expect(world.neighbouring_cells(fourth_cell).length).to eq(3)
    end

    it "can find the cells available for occupation around a around a given cell" do
      expect(world.occupiable_neighbouring_squares(cell).length).to eq(2)
      expect(world.occupiable_neighbouring_squares(fourth_cell).length).to eq(5)
    end

    it "can detect if a square contains food" do
      expect(world.square_contains_food?(0,0)).to be(false)
      expect(world.square_contains_food?(2,2)).to be(true)
      expect(world.square_contains_food?(3,3)).to be(true)
    end

    it "can persist changes to the contents of its grid to the database" do
      grid = world.instance_variable_get(:@grid)
      grid[0][1].satiety = 5
      world.persist_grid
      expect(cell.satiety).to eq(5)
    end
  end
end

