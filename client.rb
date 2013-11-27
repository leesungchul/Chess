require 'socket'      # Sockets are in standard library

hostname = '10.0.1.48' #'199.241.200.213'
port = 8081

def open_client
  begin
    s = TCPSocket.open(hostname, port)
  rescue
    retry
  end

  result = yield(s)
  s.close
  result
end

def client_read
  open_client do |s|
    s.recv(100)
  end
end

def client_write(str)
  open_client do |s|
    s.send(str,0)
  end
end

def open_server
  server = TCPServer.open(8081)
  client = server.accept
  out = yield(client)
  client.close
  out
end