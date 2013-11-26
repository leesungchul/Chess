require "colorize"
require_relative "Queen.rb"
require_relative "Rook.rb"

class Board
  def initialize
    @grid = Array.new(8) { Array.new(8) { :empty } }
    self[[4,5]] = Queen.new([4,5], :white, self)
    self[[0,5]] = Rook.new([3,5], :black, self)
  end

  def [](coords)
    x, y = coords
    return nil unless x.between?(0,7) && y.between?(0,7)
    @grid[y][x]
  end

  def []=(coords, value)
    x, y = coords
    @grid[y][x] = value
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

  def move_piece(start_pos, end_pos)
    raise RuntimeError.new("Empty Square") if self[start_pos] == :empty
    raise RuntimeError.new("Outside of Grid") if self[start_pos].nil?
    piece = self[start_pos]
    raise RuntimeError.new("Invalid Move") unless piece.moves.include?(end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = :empty
    piece.pos = end_pos
  end



end

b = Board.new
b.render
b.move_piece([4,5],[0,5])
b.render