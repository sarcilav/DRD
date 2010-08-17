require 'socket'
require 'yaml'
class Server
  attr_accesible :server, :tables_selecteds, :club
  def initialize(config,casino)
    @server = TCPServer.open(config["port"])
    @club = casino
    @tables_selecteds = {}
  end
  
  def start
    loop {
      Thread.start(@server.accept) do |client|
        request = YAML::load client.gets
        # request must have userid, type, what, amount, table
        client.close
      end
    }
  end
end


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

# View include
require APP_ROOT + '/view/game'
# Game loop
game = Game.new(club)

# real loop
while true
  game.turn
end
