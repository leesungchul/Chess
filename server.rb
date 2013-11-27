require 'socket'               # Get sockets from stdlib

server = TCPServer.open(2000)  # Socket to listen on port 2000
client = server.accept       # Wait for a client to connect

loop {                         # Servers run forever

  puts client.recv(100)
  client.send(gets, 0) # Send the time to the client
  # client.puts "Closing the connection. Bye!"
  # client.close                 # Disconnect from the client
}