require_relative "networking"

class RemotePlayer
  attr_accessor :color

  def get_move(board, position)
    position == :server ? (socket = server) : (socket = client)
    eval(recv(socket))
  end
end