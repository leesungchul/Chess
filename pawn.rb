# encoding: utf-8
require_relative "Piece.rb"

class Pawn < Piece

  def initialize(*args)
    super(*args)
    @start_pos = pos
    color == :white ? (@dy = -1) : (@dy = 1)
  end

  def moves
    moves = []
    if @board[[x, y + @dy]] == :empty
      moves << [x, y + @dy]
      if self.pos == @start_pos &&  @board[[x, y + 2 * @dy]] == :empty
        moves << [x, y + 2 * @dy]
      end
    end
    moves << [x+1, y + @dy] if check_diagonal(x + 1, y + @dy)
    moves << [x-1, y + @dy] if check_diagonal(x - 1, y + @dy)
    moves
  end

  def check_diagonal(x_diag, y_diag)
    diagonal_move = @board[[x_diag, y_diag]]
    diagonal_move && diagonal_move != :empty &&
                          diagonal_move.color != self.color
  end

  def white_symbol
    "♙"
  end

  def black_symbol
    "♟"
  end
end

