require 'yaml'

APP_ROOT = File.dirname(__FILE__)
# Model include
require APP_ROOT + '/model/beat'
require APP_ROOT + '/model/croupier'
require APP_ROOT + '/model/player'
require APP_ROOT + '/model/roulleteItem'
require APP_ROOT + '/model/table'

table_config = YAML.load_file( File.join( APP_ROOT, '/config', 'table.yml' ) )


# Control include
require APP_ROOT + '/control/club'
require APP_ROOT + '/control/game_machine'

club_config = YAML.load_file( File.join( APP_ROOT, '/config', 'club.yml' ) )
club = Club.new(club_config, table_config)

# Game loop
puts "Number of players: "
players_count = STDIN.gets.to_i
while players_count < 0
  puts "Please enter a integer greater than 0"
  players_count = STDIN.gets.to_i
end
for i in 1..players_count
  puts "Choose username for player #{i}: "
  username = STDIN.gets
  while club.enter_player(username) == false
    puts "username already taken, please re-enter"
    username = STDIN.gets
  end
end

puts "Choose your table [0-#{club.tables_count-1}]"
table_selected = STDIN.gets.to_i
while 0 > table_selected and table_selected >= club.tables_count
  puts "Please select a table between [0-#{club.tables_count-1}]"
  table_selected = STDIN.gets.to_i
end

croupier = club.croupiers[table_selected]

# real loop
puts "you can beat for one number between [0-36]\nto a color 'black' or 'red'\nto a gap '1-12' '13-24' '25-36'\nplease specific the type number, color  or gap\n"
while true
  club.players.each_pair do |index,player|
    puts "Your beat's type"
    type = STDIN.gets
    puts "to"
    thing = STDIN.gets
    if type == "number"
      thing = thing.to_i
    end
    puts "how many?"
    puts player.money
    money = STDIN.gets
    if player.place_beat(croupier,money,thing,type) == true
      puts "You don't that money :p, see you next time"
    end
  end
  winner_item = croupier.spin
  puts "Winner item #{winner_item}"
  croupier.pay_winners(winner_item)
  puts "new total"
  club.players.each_pair do |index,player|
    puts "#{index} has #{player.money}"
  end
  croupier.clean_beats
end
