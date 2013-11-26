# encoding: utf-8
require_relative "SteppingPiece.rb"

class King < SteppingPiece
  def steps
    [[0,1], [0,-1], [1,0], [-1,0]] +
    [[1,1], [1,-1], [-1,1], [-1,-1]]
  end

  WHITE_SYMBOL = "♔"
  BLACK_SYMBOL = "♚"
end