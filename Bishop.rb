# encoding: utf-8
require_relative "SlidingPiece.rb"

class Bishop < SlidingPiece
  def move_dirs
    [[1,1], [1,-1], [-1,1], [-1,-1]]
  end

  WHITE_SYMBOL = "♗"
  BLACK_SYMBOL = "♝"
end