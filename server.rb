require 'socket'               # Get sockets from stdlib

server = TCPServer.open(2000)  # Socket to listen on port 2000
loop {                         # Servers run forever
  client = server.accept      # Wait for a client to connect
  web = client.gets.chomp
  if web == "GET /index.html HTTP/1.0"
  	client.puts File.open("index.html").readlines
  end

  #client.puts(Time.now.ctime)  # Send the time to the client
  #client.puts "Closing the connection. Bye!"
  client.close                 # Disconnect from the client
}