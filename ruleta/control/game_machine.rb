require 'rubygems'
require 'statemachine'
class GameMachine
  attr_accessor :statemachine
  def initialize
    game_machine = Statemachine.build do
      trans :waiting, :beat, :active
      trans :active, :beat, :active
      trans :active, :timeOver, :postBeats
      trans :postBeats, :beat, :postBeats
    end
    @statemachine = game_machine
  end
end


