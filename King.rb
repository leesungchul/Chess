# encoding: utf-8
require_relative "stepping_piece.rb"

class King < SteppingPiece
  def steps
    [[0,1], [0,-1], [1,0], [-1,0]] +
    [[1,1], [1,-1], [-1,1], [-1,-1]]
  end

  def white_symbol
    "♔"
  end

  def black_symbol
    "♚"
  end
end