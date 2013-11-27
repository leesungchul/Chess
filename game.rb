require_relative "board.rb"
require_relative "player.rb"

class Game
  def initialize(player1, player2)
    @board = Board.new
    @board.checkmate?(:white)
    @board.render
    @player1, @player2 = player1, player2
    @player1.color = :white
    @player2.color = :black
  end

  def play
    current_player = @player1
    until @board.checkmate?(current_player.color)
      @board.render
      begin
        start_pos, end_pos = current_player.get_move(@board)
        @board.move_piece(start_pos, end_pos, current_player.color)
      rescue RuntimeError => error
        puts error.message
        retry
      end

      current_player = current_player == @player1 ? @player2 : @player1
    end
    print "Checkmate!"
  end
end

if __FILE__ == $0
  g = Game.new(Player.new, Player.new)
  g.play
end