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
puts "Number of players: "
players_count = STDIN.gets
for i in 1..players_count
  puts "Choose username for player #{i}: "
  username = STDIN.gets
  while club.enter_player(username) == false
    puts "username already taken, please re-enter"
    username = STDIN.gets
  end
end
puts "Choose your table [0-#{club.tables_count-1}]"



