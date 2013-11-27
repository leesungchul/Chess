require_relative "networking"

class RemotePlayer

  def get_move(board, position)
    socket = (position == :server ? server : client)
    eval(socket.recv)
  end
end