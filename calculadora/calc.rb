class Calc
  attr_accessor :m, :last
  def initialize
    @m = 0
    @last = 0
  end
  def sumar(a,b)
    @last = a+b
  end
  def restar(a,b)
    @last = a-b
  end
  def multiplicar(a,b)
    @last = a*b
  end
  def dividir(a,b)
    @last = a/b
  end
  def mc
    @m = 0
    @last = @m
  end
  def mr
    @last = @m
  end
  def mmas
    @m += @last
    @last = @m
  end
  def ev(input)
    arg = input.split(" ")
    puts arg
    if arg[1].nil?
      if arg[0][1].chr == '+'
        mmas
      else
        eval "#{arg[0]}"
      end
    else
      eval "#{arg[1]}(#{arg[0]},#{arg[2]})"
    end
  end
end
