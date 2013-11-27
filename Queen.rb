# encoding: utf-8
require_relative "sliding_piece.rb"

class Queen < SlidingPiece
  def move_dirs
    [[0,1], [0,-1], [1,0], [-1,0]] +
    [[1,1], [1,-1], [-1,1], [-1,-1]]
  end

  def white_symbol
    "♕"
  end

  def black_symbol
    "♛"
  end
end