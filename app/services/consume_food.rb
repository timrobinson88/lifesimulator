class ConsumeFood
  def initialize(cell, food_square)
    @cell = cell
    @food_square = food_square
  end

  def consume
    @food_square.destroy!
    @cell.satiety = 10
  end
end