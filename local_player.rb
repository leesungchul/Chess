require_relative "networking"

class LocalPlayer
  attr_accessor :color

  def get_move(board, position)
    board.start_x = nil
    board.start_y = nil
    while true
      system "clear"
      board.render
      char = get_char
      case char
      when "w"
        board.up
      when "a"
        board.left
      when "s"
        board.down
      when "d"
        board.right
      when " "
        board.select_square
      when "."
        board.dup.make_move(color)

        break unless board.start_x.nil?
      when "q"
        system "clear"
        exit(0)
      end
    end

    move = [[board.start_x, board.start_y], [board.cursor_x, board.cursor_y]]

    send(move, position)

    move
  end

  def get_char
    char = ""
    begin
      system("stty raw -echo")
      char = STDIN.getc
    ensure
      system("stty -raw echo")
    end
  end

  def send(move, position)
    socket = (position == :server ? server : client)
    socket.send(move.inspect)
  end
end