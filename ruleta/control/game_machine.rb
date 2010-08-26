require 'rubygems'
require 'statemachine'
class GameMachine
  attr_accessor :statemachine
  def initialize
    game_machine = Statemachine.build do
      state :waiting do
        event :beat, :active
      end
      trans :active, :beat, :active
      trans :active, :timeOver, :postBeats
      trans :postBeats, :beat, :postBeats
      trans :postBeats, :ready, :waiting
      context Croupier.new
    end
    game_machine.context.statemachine = game_machine
    @statemachine = game_machine
  end
end


