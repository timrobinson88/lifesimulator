class World
  def initialize(height, width)
    @height = height
    @width = width
    @grid = height.times.map{ [] } 
    @grid.each_with_index do |row, y| 
      width.times { |x| row << EmptySquare.new(x, y) }
    end
  end

  def each_square
     @grid.each do |row|
      row.each do |square|
        yield square
      end
    end
  end

  def persist_grid
    each_square do |square|
      square.save! if square.can_be_saved?
    end
  end

  def populate
    @cells = Cell.all
    @cells.each { |cell| map_to_grid(cell) }
  end

  def map_to_grid(cell)
    @grid[cell.y][cell.x] = cell
  end

  def empty_neighbouring_squares(cell)
    neighbouring_squares(cell).select { |contents| contents.class == EmptySquare }
  end

  def neighbouring_cells(cell)
    neighbouring_squares(cell).select { |contents| contents.class == Cell }
  end

  def neighbouring_squares(cell)
    start_x = [cell.x - 1, 0].max
    start_y = [cell.y - 1, 0].max
    end_x   = [cell.x + 1, @width - 1].min
    end_y   = [cell.y + 1, @height - 1].min

    (start_y..end_y).flat_map do |y|
      (start_x..end_x).flat_map do |x|
        @grid[y][x] unless x == cell.x && y == cell.y
      end
    end.compact
  end
end