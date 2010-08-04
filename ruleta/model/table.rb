class Table
  attr_accessor :roullete, :history
  # table must be a hash in the following way
  # { int =>{"gap" => "int-otherInt", "color" => color} , ... }
  def initialize(table)
    @roullete = []
    for i in 0..table["size"]
      @roullete.push RoulleteItem.new(i,table[i])
    end
    @history = []
  end
end
