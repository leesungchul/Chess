class Player
  attr_accessor :color
  def get_move
    puts "Enter your move as two arrays"
    eval(gets.chomp)
  end
end