require 'drb'
class Player
  
end
DRb.start_service nil, Player.new
room = DRbObject.new nil, ARGV.shift
puts "Insert your player alias"
name = STDIN.gets.chomp
room.login(name,DRb.uri)
puts "puts l to see free players"
while line = STDIN.gets.chomp
  if line == "l"
    puts room.list
  elsif
end
