class MoveCell
  def initialize(cell, destination, world)
    @cell = cell
    @destination = destination
    @world = world
  end

  def move
    @world.add_to_grid(EmptySquare.new(@cell.x, @cell.y))
    update_cell
    if @world.square_contains_food?(@destination.x, @destination.y)
      ConsumeFood.new(@cell, @destination).consume
    end
    
    @world.add_to_grid(@cell)
  end

  private

  def update_cell
    @cell.x = @destination.x
    @cell.y = @destination.y
    @cell.satiety -= 2
  end
end