require 'socket'               # Get sockets from stdlib
require 'json'

server = TCPServer.open(2000)  # Socket to listen on port 2000
loop {                         # Servers run forever
  client = server.accept      # Wait for a client to connect
  request = client.gets
  puts request
  if request =~ (/GET(.*)/ )
  	page = request.split(" ")[1][1..-1] #Get middle word of request, remove leading '/'
  	if File.file?(page)
  	  lines = File.open(page).readlines
  	    client.puts "HTTP/1.0 200 OK"
  	  	client.puts "Date: #{Time.now}"
  	  	client.puts "Content-Type: text/html"
  	  	client.puts "Content-Length: #{lines.join.size}\r\n\r\n\ " #Server html reply
     	client.puts lines
  	else
  	  client.puts "HTTP/1.0 404 Not Found \r\n\r\n "
  	  client.puts "Error 404, file not found!"
  	end
  	if request =~ (/POST(.*)/ )
  	 puts request
  	end
  end

  #client.puts(Time.now.ctime)  # Send the time to the client
  #client.puts "Closing the connection. Bye!"
  client.close                 # Disconnect from the client
}