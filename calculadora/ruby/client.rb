require 'socket'
hostname = 'localhost'
port = '9090'

s = TCPSocket.open hostname, port
while operation = STDIN.gets.split(" ")
  a = operation.shift
  op = operation.shift
  b = operation.shift
  s.puts "#{a} #{op} #{b}"
  line = s.gets   # Read lines from the socket
  puts line.chop      # And print with platform line terminator
end
s.close

