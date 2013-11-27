# encoding: utf-8
require_relative 'stepping_piece.rb'

class Knight < SteppingPiece
  def steps
    steps = [[1, 2], [2, 1]]
    steps+=steps.map { |x, y| [x, -y] }
    steps+=steps.map { |x, y| [-x, y] }
    steps
  end

  def white_symbol
    "♘"
  end

  def black_symbol
    "♞"
  end
end