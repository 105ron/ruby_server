require 'socket'               # Get sockets from stdlib
require 'json'



server = TCPServer.open(2000)  # Socket to listen on port 2000
loop {                         # Servers run forever
  client = server.accept      # Wait for a client to connect
  request = ""
  

  while line = client.gets
    request << line
    break if request =~ /\r\n\r\n$/
  end
  

  page = request.split(" ")[1][1..-1] #Get middle word of request, remove leading '/' e.g. index.html
  

  if request =~ (/GET(.*)/ )
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
  end
  if request =~ (/POST(.*)/ )
    puts request
    header,data = request.split("\r\n", 2)
    data = data.chomp.chomp[1..-1]
    params = Hash.new
    params = JSON.parse(data)
    list_entries = ""
    params["viking"].each do |key, value|
      list_entries += "<li>#{key}: #{value}</li>\n      "
    end
    if File.file?(page)
      file = File.open(page)
      lines = file.read.gsub("<%= yield %>", list_entries)
      client.puts "HTTP/1.0 200 OK"
      client.puts "Date: #{Time.now}"
      client.puts "Content-Type: text/html"
      client.puts "Content-Length: #{lines.length}\r\n\r\n\ " #Server html reply
      client.puts lines
    else
      client.puts "HTTP/1.0 404 Not Found \r\n\r\n "
      client.puts "Error 404, file not found!"
    end

  end

  #client.puts(Time.now.ctime)  # Send the time to the client
  #client.puts "Closing the connection. Bye!"
  

  client.close                 # Disconnect from the client
}

