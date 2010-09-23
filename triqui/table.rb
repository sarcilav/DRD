class Table
  attr_accessor :status, :player1, :player2
  def initialize(name1,name2)
    @player1 = name1
    @player2 = name2
    @status = [ [0,0,0], [0,0,0], [0,0,0] ]
  end
  # return true if place mark
  # return false otherwise
  # player must be 1|-1
  def place_mark(i,j,player)
    if @status[i][j] == 0
      @status[i][j] == player
      return true
    end
    return false
  end
  def check(rc)
    acum = 0
    rc.each do |x|
      acum+=x
    end
    return acum.to_f/3
  end
  # return -1 if player -1 win
  # return 1 if player 1 win
  # return 0 if no player yet win
  def check_winner
    # check row and column
    (0..2).each do |i|
      ans = check(@status[i])
      if ans == 1
        return 1
      elsif ans == -1
        return -1
      end
      ans = check([@status[0][i],@status[1][i],@status[2][i]])
      if ans == 1
        return 1
      elsif ans == -1
        return -1
      end
    end
    # check diagonals
    ans = check([@status[0][0],@status[1][1],@status[2][2]])
    if ans == 1
      return 1
    elsif ans == -1
      return -1
    end
    ans = check([@status[0][2],@status[1][1],@status[2][0]])
    if ans == 1
      return 1
    elsif ans == -1
      return -1
    end
    return 0
  end
end
