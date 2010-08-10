class Game
  attr_accessor :tables_selecteds, :club
  def initialize(casino)
    @club = casino
    @tables_selecteds = {}
    puts "Number of players: "
    players_count = STDIN.gets.to_i
    while players_count < 0
      puts "Please enter a integer greater than 0"
      players_count = STDIN.gets.to_i
    end
    for i in 1..players_count
      puts "Choose username for player #{i}: "
      username = STDIN.gets.chomp
      while @club.enter_player(username) == false
        puts "username already taken, please re-enter"
        username = STDIN.gets.chomp
      end
      puts "Choose your table [0-#{@club.tables_count}],#{username}"
      table_selected = STDIN.gets.to_i
      while 0 > table_selected and table_selected > @club.tables_count
        puts "Please select a table between [0-#{@club.tables_count}]"
        table_selected = STDIN.gets.to_i
      end
      @tables_selecteds[username] = table_selected
    end
  end
  def turn
    puts "you can beat for one number between [0-36]\nto a color 'black' or 'red'\nto a gap '1-12' '13-24' '25-36'\nplease specific the type number, color  or gap\n"
    @club.players.each_pair do |index,player|
      puts "Your beat's type #{index}"
      type = STDIN.gets.chomp
      puts "to"
      thing = STDIN.gets.chomp
      if type == "number"
        thing = thing.to_i
      end
      puts "how many?"
      money = STDIN.gets.to_i
      if player.place_beat(@club.croupiers[@tables_selecteds[index]],money,thing,type) == false
        puts "You don't have that money :p, see you next time"
      end
    end
    @club.croupiers.each do |croupier|
      croupier.spin
    end

    @club.players.each_pair do |index,player|
      puts "#{index} the winner item in the table #{@tables_selecteds[index]} is #{@club.croupiers[@tables_selecteds[index]].table.history.last}"
    end
      
    @club.croupiers.each do |croupier|
      croupier.pay_winners(croupier.table.history.last)
      croupier.clean_beats
    end
    puts "new total"
    @club.players.each_pair do |index,player|
      puts "#{index} has #{player.money}"
    end
  end
end
