require 'socket'      # Sockets are in standard library

hostname = '10.0.1.48' #'199.241.200.213'
port = 8081

def client
  begin
    server = TCPSocket.open('10.0.1.48', 8081)
  rescue => error
    retry
  end

  server
end

def server
  server = TCPServer.open(8081)
  server.accept
end

def recv(place)
  place.recv(100)
end

def send(place,str)
  place.send(str,0)
end