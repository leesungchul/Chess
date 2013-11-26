# encoding: utf-8
require_relative "SlidingPiece.rb"

class Rook < SlidingPiece
  def move_dirs
    [[0,1], [0,-1], [1,0], [-1,0]]
  end

  def white_symbol
    "♖"
  end

  def black_symbol
    "♜"
  end
end