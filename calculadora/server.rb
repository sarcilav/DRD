require 'socket'
require 'calc'
port = 9090
server = TCPServer.open(9090)   # Socket to listen on port 2000
loop {                          # Servers run forever
  Thread.start(server.accept) do |client|
    calc = Calc.new
    while request = client.gets
      calc.ev request
      client.puts "<int>#{calc.last}</int>"
    end
    client.close                # Disconnect from the client
  end
}
