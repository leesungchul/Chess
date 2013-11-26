class Piece


  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
  end

  def x
    pos[0]
  end

  def y
    pos[1]
  end

  def to_s
    if @color == :white
      white_symbol
    else
      black_symbol
    end
  end


end


