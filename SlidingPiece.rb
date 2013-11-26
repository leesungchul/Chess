require_relative 'Piece.rb'

class SlidingPiece < Piece
  def moves
    moves = []

    diffs = move_dirs

    diffs.each do |diff|
      dx, dy = diff
      x2, y2 = x, y
      while true
        x2, y2 = x2 + dx, y2 + dy

        contents = board[x2,y2]
        if contents == :empty
          moves << [x2,y2]
        elsif contents.nil?
          break
        elsif contents.color != self.color
          moves << [x2,y2]
          break
        else
          break
        end
      end
    end
    moves
  end
end
