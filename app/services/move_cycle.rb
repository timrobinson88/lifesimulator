class MoveCycle
  def run
    @world = World.new(3,3)
    @world.populate

    @world.each_cell do |cell|
      cell.attempt_to_move(@world.occupiable_neighbouring_squares(cell), @world)
    end

    @world
  end
end