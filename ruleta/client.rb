require 'socket'
require 'yaml'
APP_ROOT = File.dirname(__FILE__)
require APP_ROOT + '/lib/util'
class Client
  attr_accessor :client, :user, :table, :hostname, :port
  def initialize(config,user,table)
    @hostname = config["hostname"]
    @port = config["port"]
    @user = user
    @table = table
  end

  def connect
    @client = TCPSocket.open @hostname, @port
  end

  def close
    @client.close
  end

  def send_beat(type, what, amount)
    @client.puts "user: #{@user}#{separator}table: #{@table}#{separator}type: #{type}#{separator}what: #{what}#{separator}amount: #{amount}"
  end

  def recv
    YAML::load(decode_separator(@client.gets))
  end
end

def turn(client)
  puts "you can beat for one number between [0-36]\nto a color 'black' or 'red'\nto a gap '1-12' '13-24' '25-36'\nplease specific the type number, color  or gap\n"
  puts "Your beat's type"
  type = STDIN.gets.chomp
  puts "to"
  thing = STDIN.gets.chomp
  if type == "number"
    thing = thing.to_i
  end
  puts "how many?"
  money = STDIN.gets.to_i
  client.connect
  client.send_beat type, thing, money
  response = client.recv
  if response["status"] != "OK"
    puts "Sorry you don't have that money, good bye"
    client.close
    return false
  end
  puts response["winner"]
  puts "#{response['user']} you have $#{response['money']}"
  client.close
  return true
end

config = YAML.load_file( File.join( APP_ROOT, '/config', 'server.yml' ) )
puts "Insert your username"
user = STDIN.gets.chomp
puts "Choose a table number [0-9]"
table = STDIN.gets.chomp
client = Client.new(config,user,table)

while turn(client)
end
