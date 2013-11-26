require "colorize"
require_relative "Queen.rb"

class Board
  def initialize
    @grid = Array.new(8) { Array.new(8) { :empty } }
    @grid[4][5] = Queen.new([4,5], :white, self)
  end

  def [](coords)
    return nil unless coords.all? { |coord| coord.between?(0,7) }
    x,y = coords
    grid[y][x]
  end

  def render
    puts "  0 1 2 3 4 5 6 7 "
    @grid.each_with_index do |row, y|
      print "#{y} "
      row.each_with_index do |square, x|
        if square == :empty
          string = " "
        else
          string = square.to_s
        end

        if (x+y) % 2 == 0
          print (string+" ").light_black.on_white
        else
          print (string+" ").light_black.on_black
        end
      end
      puts
    end
  end
end

b = Board.new
b.render