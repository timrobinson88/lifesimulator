class DestroyCell
  def initialize(cell, world)
    @cell = cell
    @world = world
  end

  def destroy
    empty_square = EmptySquare.new(@cell.x, @cell.y)
    @cell.destroy!
    @world.add_to_grid(empty_square)
  end
end