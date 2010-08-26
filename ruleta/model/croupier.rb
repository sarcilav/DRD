class Croupier
  attr_accessor :table, :beats, :can_beat
  # can_beat : 0 no beats, :1 ready, :2 beating
  def initialize(table_config)
    @table = Table.new(table_config)
    @beats = []
    @can_beat = 1
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
    puts "#{player} esta apostando #{money}"
    if @can_beat != 0
      spin_time
      if type == "color"
        new_money = money/18.0
      elsif type == "gap"
        new_money = money/12.0
      elsif type == "number"
        new_money = money
      else
        return false
      end
      @table.roullete.each do |rItem|
        if eval("rItem.#{type}") == thing
          beat = Beat.new(player, new_money, rItem)
          @beats.push beat
        end
      end
      return true
    end
    return false
  end
  def spin_time
    if @can_beat == 1
      Thread.new do
        sleep(30)
        @can_beat = 0
        winner = spin
        for i in @beats
          i.player.notify_winner(winner)
        end
        pay_winners(winner)
        clean_beats
      end
    end
    @can_beat = 2
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
    @can_beat = 1
  end
end
