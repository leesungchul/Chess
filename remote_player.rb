require_relative "networking"

class RemotePlayer
  attr_accessor :color

  def get_move(board, position)
    puts "argle"
    position == :server ? (socket = server) : (socket = client)
    puts "lol"
    puts msg = recv(socket)
    eval(msg)
  end
end