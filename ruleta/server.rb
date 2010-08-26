require 'drb'
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

#Server
require APP_ROOT + '/lib/util'
class Server
  attr_accessor :server, :club 
  def initialize(casino)
    @club = casino
  end

  def login(user, uri)
    @club.enter_player(user,uri)
  end
  def beat(user,table,money,thing,type)
    @club.players[user].place_beat(@club.croupiers[table], money, thing, type)
  end
end

server_config = YAML.load_file( File.join( APP_ROOT, '/config', 'server.yml' ))

DRb.start_service "druby://#{server_config['hostname']}:#{server_config['port']}" , Server.new(club)
puts DRb.uri
DRb.thread.join
