class RoulleteItem
  attr_accessor :number, :color, :gap
  # settings : { "color" => color, "gap" => gap }
  def initialize(number, settings)
    @number = number
    @color = settings["color"]
    @gap = settings["gap"]
  end
  def to_s
    "number: #{@number} color: #{@color} gap: #{@gap}"
  end
end
