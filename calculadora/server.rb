require 'socket'
port = 9090
server = TCPServer.open(9090)   # Socket to listen on port 2000
def sumar(a,b)
  a+b
end
def restar(a,b)
  a-b
end
def multiplicar(a,b)
  a*b
end
def dividir(a,b)
  a/b
end
loop {                          # Servers run forever
  Thread.start(server.accept) do |client|
    m = 0
    last = 0
    while ans = client.gets.split(" ")
      if ans[1].nil?
        if ans[0].downcase == 'mc'
          m = 0
        elsif ans[0].downcase == 'mr'
          ans = m
        elsif ans[0].downcase == 'm+'
          m += last
          ans = m
        else
          raise Exception(ans[0])
        end
      else
        ans = eval("#{ans[1]}(#{ans[0]},#{ans[2]})")
        last = ans
      end
      client.puts "<int>#{ans}</int>"
    end
    #client.close                # Disconnect from the client
  end
}
