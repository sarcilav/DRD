class Player
  attr_accessor :user_name, :money, :beats
  def initialize(user_name,money = 1000)
    @user_name = user_name
    @money = money
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
  # return can you place?
  def place_beat(croupier, money, thing, type = "number")
    if @money >= money
      @money -= money
      @beats.push croupier.recv_beat(money,type,thing, self)
      return true
    else
      return false
    end
  end
  # return amount of money you win!!!
  def recv_money(money)
    @money += money
    return money
  end
end
