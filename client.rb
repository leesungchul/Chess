require 'socket'      # Sockets are in standard library

hostname = '10.0.1.48' #'199.241.200.213'
port = 8081

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