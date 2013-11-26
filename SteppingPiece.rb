require_relative "Piece.rb"

class SteppingPiece

  def initialize
    super
  end

  def moves
    moves = []
    steps.each do |step|
      step_x, step_y = step
      x2, y2 = x + step_x, y + step_y
      contents = board[x2, y2]
      if contents == :empty || contents.color != self.color
        moves << [x2, y2]
      end
    end
    moves
  end
end