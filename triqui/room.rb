require 'table'
require 'drb'
class Room
  attr_accessor :players,:limit, :free_players, :tables
  def initialize
    @limit = 20
    @players = {}
    @free_players = {}
    @tables = {}
  end
  # return true in correct login
  def login(name,uri)
    if @players[name].nil? and @players.size < @limit
      @players[name] = uri
      @free_players[name] = true
      return true
    end
    return false
  end
  def logout(name)
    @players.reject! { |key,value| key == name }
    @free_players.reject! {|key,value| key == name }
  end
  # list all the players that are not playing
  def list
    l = ""
    @free_players.each_pair do |key,value|
      if value
        l += "#{key}\n"
      end
    end
    return l
  end
  def start_game(player1,player2)
    @free_players[player1] = false
    @free_players[player2] = false
    table = Table.new(player1,player2)
    @tables["#{player1-player2}"] = table
  end
end
DRb.start_service nil, Room.new
puts DRb.uri


DRb.thread.join
