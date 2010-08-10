class Club
  attr_accessor :croupiers, :tables_count, :players
  # club must be a hash that contains {'number_of_tables'=> integer, 'number_per_tables' => integer}
  def initialize(club,table_config)
    @croupiers = []
    @players = {}
    @tables_count = club['number_of_tables'] - 1
    for i in 0..@tables_count
      @croupiers.push Croupier.new(table_config)
    end
  end
  
  def enter_player(user_name)
    if @players[user_name].nil?
      @players[user_name] = Player.new(user_name)
    end
  end

  
end
