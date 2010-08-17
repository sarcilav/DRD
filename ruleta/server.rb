require 'socket'
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
  def initialize(config,casino)
    @server = TCPServer.open(config["port"])
    @club = casino
  end

  def start
    loop {
      Thread.start(@server.accept) do |client|
        # request must have userid, type, what, amount, table
        request = YAML::load(decode_separator(client.gets))
        user = request["user"]
        table = request["table"]
        type = request["type"]
        thing = request["what"]
        money = request["amount"]
        ans = ""
        @club.enter_player user
        if @club.players[user].place_beat @club.croupiers[table], money, thing, type
          ans += "status: OK#{separator}"
        else
          ans += "status: Error#{separator}"
          return
        end
        @club.croupiers[table].spin
        winner = @club.croupiers[table].table.history.last
        ans += "winner: #{winner}#{separator}"
        @club.croupiers[table].pay_winners winner
        @club.croupiers[table].clean_beats
        ans += "user: #{user}#{separator}money: #{@club.players[user].money}"
        client.puts ans
        client.close
      end
    }
  end
end

server_config = YAML.load_file( File.join( APP_ROOT, '/config', 'server.yml' ))

server = Server.new(server_config, club)
server.start
