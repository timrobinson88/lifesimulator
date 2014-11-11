class MoveCycle
  def initialize(world)
    @world = world
  end
  
  def run
    
    @world.each_cell do |cell|
      cell.attempt_to_move(@world.occupiable_neighbouring_squares(cell), @world)
    end

    @world
  end
end