class Beat
  attr_accessor :money, :player, :roulleteItem
  def initialize(player, money, thing)
    @money = money
    @player = player
    @roulleteItem = thing
  end
end
