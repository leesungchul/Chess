require 'socket'      # Sockets are in standard library

hostname = 'localhost'
port = 2000

begin
  s = TCPSocket.open(hostname, port)
rescue
  retry
end

loop {
  s.send(gets, 0)
  puts line = s.recv(100)
}
s.close               # Close the socket when done