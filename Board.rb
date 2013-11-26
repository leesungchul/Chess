class Board

  def initialize
    @grid = Array.new(8) { Array.new(8) { :empty } }
  end

  def [](coords)
    return nil unless coords.all? { |coord| coord.between?(0,7) }
    x,y = coords
    grid[y][x]
  end

end