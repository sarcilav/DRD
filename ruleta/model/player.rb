class Player
  attr_accessor :user_name, :money,:uri
  def initialize(user_name,uri,money = 1000)
    @user_name = user_name
    @money = money
    @uri = uri
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
      return croupier.recv_beat(money,type,thing, self)
    else
      return false
    end
  end
  # return amount of money you win!!!
  def recv_money(money)
    @money += money
    return money
  end
  def notify_winner(winner_item)
    client = DRbObject.new nil, @uri
    client.recv_winner_item(winner_item.to_s)
  end
end
