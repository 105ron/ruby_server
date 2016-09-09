require 'socket'
require 'json'
 
host = 'localhost'     # The web server
port = 2000            # Default HTTP port

#Get user input before we send the request to the server
puts "Would you like to POST or GET to the page?(post/get)"
option = gets.chomp
puts "Whats is the name of the file you would like to retrieve? (index.html for get and thanks.html for post)"
path = gets.chomp


if option == "post"
  puts "Pretend you're registering a viking for a raid."
  puts "What's your viking name?"
  viking_name = gets.chomp
  puts "What's your viking email?"
  viking_email = gets.chomp
  viking_hash = {:viking => {:name=>viking_name,:email=>viking_email}}
  viking_json = viking_hash.to_json
  request = <<POST_REQUEST
POST /#{path} HTTP/1.0
From: frog@jmarshall.com
Content-Type: application/json
Content-Length: #{viking_json.length}
\r\n #{viking_json}\r\n\r\n
POST_REQUEST

else  #We will just get the #{path} if there's an error in option variable input
  request = "GET /#{path} HTTP/1.0\r\n\r\n"
end


puts request
socket = TCPSocket.open(host,port)  # Connect to server
socket.print(request)               # Send request
response = socket.read              # Read complete response
# Split response at first blank line into headers and body
# Split response at first blank line into headers and body
headers,body = response.split("\r\n\r\n", 2) 
puts headers
puts ""
puts "" #separate headers from body
puts body