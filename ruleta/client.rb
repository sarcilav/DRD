require 'drb'
require 'yaml'
APP_ROOT = File.dirname(__FILE__)
require APP_ROOT + '/lib/util'
class Client
  def recv_money_status(money)
    puts "Your balance: #{money}"
  end
  def recv_winner_item(item)
    puts "The winner item is  #{item}"
  end
end

def turn(server,user,table)
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
  server.beat(user,table,money, thing,type)
end

puts "Insert your username"
user = STDIN.gets.chomp
puts "Choose a table number [0-9]"
table = STDIN.gets.chomp.to_i

DRb.start_service nil, Client.new
server = DRbObject.new nil, ARGV.shift
server.login(user, DRb.uri)

loop { turn(server,user,table) }
