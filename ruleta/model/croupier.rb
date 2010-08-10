class Croupier
  attr_accessor :table, :beats
  def initialize(table_config)
    @table = Table.new(table_config)
    @beats = []
  end
  # type must be (color,gap,number)
  # thing must be
  # if type = color
  #   black | red
  # if type = number
  #   [0,36] one number
  # if type = gap
  #   "1-12" | "13-24" | "25-36"
  def recv_beat(money,type,thing,player)
    if type == "color"
      new_money = money/18.0
    elsif type == "gap"
      new_money = money/12.0
    elsif type == "number"
      new_money = money
    else
      raise Exception.new(type)
    end
    beats_player = []
    @table.roullete.each do |rItem|
      if eval("rItem.#{type}") == thing
        beat = Beat.new(user, new_money, rItem)
        @beats.push beat
        beats_player.push beat
      end
    end
    beats_player
  end

  def spin
    @table.history.push @table.roullete[rand(@table.roullete.size())]
    @table.history.last
  end
  
  def pay_winners(winner_roullete_item)
    for i in @beats
      if winner_roullete_item == i.roulleteItem
        i.player.recv_money(i.money * 36)
      end
    end
  end

  def clean_beats
    @beats=[]
  end
end
