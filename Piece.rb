class Piece
  attr_accessor :pos
  attr_reader :color

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

  def moves
    raise NotImplementedError
  end

  def valid_moves
    moves.select do |move|
      dup_board = @board.dup
      dup_board.move_piece!(start_pos, end_pos)
      ! dup_board.check?(self.color)
    end
  end

end