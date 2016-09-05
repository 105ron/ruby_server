require 'socket'
require 'json'

 
host = 'localhost'     # The web server
port = 2000                           # Default HTTP port
path = "/index.html"                 # The file we want 

# This is the HTTP request we send to fetch a file

puts "Would you like to POST or GET to the page?(post/get)"
option = gets.chomp
if option == "get"
	puts "get"
  request = "GET #{path} HTTP/1.0\r\n\r\n"
elsif option == "post"
  puts "Pretend you're registering a viking for a raid."
  puts "What's your viking name?"
  viking_name = gets.chomp
  puts "What's your viking email?"
  viking_email = gets.chomp
  viking_hash = {:viking => {:name=>viking_name,:email=>viking_email}}
  request = ["POST thanks.html HTTP/1.0\r\n\r\n",
 			"User-Agent: HTTPTool/1.0",
			"Content-Type: application/x-www-form-urlencoded",
			"Content-Length: #{viking_hash.to_json.length}",
			viking_hash.to_json]
#else
  #puts "Not a valid option"
end


puts request
socket = TCPSocket.open(host,port)  # Connect to server
socket.print(request)               # Send request
response = socket.read              # Read complete response
# Split response at first blank line into headers and body
# Split response at first blank line into headers and body
headers,body = response.split("\r\n\r\n", 2) 
#print body                          # And display it
puts "headers"
puts headers
puts "and body"
puts body