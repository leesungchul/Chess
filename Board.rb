require "colorize"
require_relative "queen.rb"
require_relative "rook.rb"
require_relative "king.rb"
require_relative "knight.rb"
require_relative "pawn.rb"

class Board
  def initialize
    @grid = Array.new(8) { Array.new(8) { :empty } }
    self[[4,5]] = Queen.new([4,5], :white, self)
    self[[0,5]] = Rook.new([0,5], :black, self)
    self[[3,1]] = King.new([3,1], :black, self)
    self[[4,2]] = Pawn.new([4,2], :white, self)
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

  def move_piece(start_pos, end_pos, color)
    raise RuntimeError.new("Empty Square") if self[start_pos] == :empty
    raise RuntimeError.new("Outside of Grid") if self[start_pos].nil?
    piece = self[start_pos]
    raise RuntimeError.new("Invalid Move") unless piece.valid_moves.include?(end_pos)
    self.move_piece!(start_pos, end_pos)
  end

  def move_piece!(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = :empty
    piece.pos = end_pos
  end

  def get_team_pieces(color)
    @grid.flatten.select { |x| x != :empty && x.color == color }
  end

  def get_enemy_pieces(color)
    @grid.flatten.select { |x| x != :empty && x.color != color }
  end

  def check?(color)
    enemy_pieces = get_enemy_pieces(color)
    enemy_pieces.map(&:moves).flatten(1).include?(king_pos(color))
  end

  def king_pos(color)
    get_team_pieces(color).select { |p| p.is_a?(King) }.first.pos
  end

  def checkmate?
  end


end

b = Board.new
b.render
p b.check?(:black)