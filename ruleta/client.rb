require 'socket'
require 'yaml'
class Client
  attr_accesible :client, :user, :table
  def initialize(config)
    @client = TCPSocket.open config["hostname"], config["port"]
  end
  
  def send(type, what, amount)
    @client.puts "user: #{@user}\ntable: #{@table}\ntype: #{type}\nwhat: #{what}\namount: #{amount}\n" 
  end
  
  def recv
    YAML::load @client.gets
  end
end
