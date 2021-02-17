require 'singleton'

class BigChar
  def initialize(charname)
    @fontdata = "-----#{charname}-----"
  end

  def print
    pp @fontdata
  end
end

class BigCharFactory
  include Singleton

  def initialize
    @pool = {}
  end

  def get_big_char(charname)
    big_char = @pool.select {|k,v| k == charname }.values.first

    if big_char.nil?
      big_char = BigChar.new(charname)
      @pool[charname] = big_char
    end

    big_char
  end
end

class BigString
  def initialize(string)
    @string = string.to_i
    @big_chars = []
    @factory = BigCharFactory.instance

    @string.times do |i|
      @big_chars << @factory.get_big_char(i + 1)
    end
  end

  def print
    pp @big_chars
  end
end


big_string = gets.chomp
bs = BigString.new(big_string)
bs.print