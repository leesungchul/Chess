# encoding: utf-8

require "colorize"
require_relative "required_pieces"

class Board
  attr_accessor :grid, :cursor_x, :cursor_y, :start_x, :start_y

  def initialize(new_board = true)

    @cursor_x = 0
    @cursor_y = 0
    @start_x = nil
    @start_y = nil

    make_grid if new_board

  end

  def up
    self.cursor_y = (cursor_y - 1)%8
  end

  def down
    self.cursor_y = (cursor_y + 1)%8
  end

  def left
    self.cursor_x = (cursor_x - 1)%8
  end

  def right
    self.cursor_x = (cursor_x + 1)%8
  end

  def select_square
    self.start_x, self.start_y = self.cursor_x, self.cursor_y
  end

  def make_move(color)
    return if self.start_x.nil?
    move_piece([self.start_x, self.start_y], [self.cursor_x, self.cursor_y], color)
  end

  def [](coords)
    x, y = coords
    return nil unless x.between?(0, 7) && y.between?(0, 7)
    @grid[y][x]
  end

  def []=(coords, value)
    x, y = coords
    @grid[y][x] = value
  end

  def render
    puts "  A B C D E F G H"
    @grid.each_with_index do |row, y|
      print "#{8-y} "
      row.each_with_index do |square, x|
        string = (square == :empty ? "  " : square.to_s + " ")

        string = string.blink if [x,y] == [self.start_x, self.start_y]

        if [x,y] == [cursor_x, cursor_y]
          print string.on_red
        elsif (x+y) % 2 == 0
          print string.on_white
        else
          print string.on_black
        end
      end
      puts
    end
  end

  def dup
    out = Board.new(false)
    duped_grid = []
    @grid.each do |row|
      new_row = []
      row.each do |square|
        if square.is_a? Symbol
          new_row << square
        else
          new_row << square.dup
        end
      end
      duped_grid << new_row
    end
    out.grid = duped_grid
    out.cursor_x, out.cursor_y = cursor_x, cursor_y
    out.start_x, out.start_y = start_x, start_y
    out
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
    self[end_pos].pos = end_pos
  end

  def check?(color)
    enemy_pieces = get_enemy_pieces(color)
    enemy_pieces.map(&:moves).flatten(1).include?(king_pos(color))
  end

  def checkmate?(color)
    get_team_pieces(color).map(&:valid_moves).flatten(1).empty?
  end

  private

    def make_piece(piece_class,x,y, color)
      self[[x,y]] = piece_class.new([x,y], color, self)
    end

    def make_symmetrical_pieces(piece_class, x, y)
      make_piece(piece_class, x, y, :black)
      make_piece(piece_class, 7-x, y, :black)
      make_piece(piece_class, x, 7-y, :white)
      make_piece(piece_class, 7-x, 7-y, :white)
    end

    def king_pos(color)
      get_team_pieces(color).select { |p| p.is_a?(King) }.first.pos
    end

    def get_team_pieces(color)
      @grid.flatten.select { |x| x != :empty && x.color == color }
    end

    def get_enemy_pieces(color)
      @grid.flatten.select { |x| x != :empty && x.color != color }
    end

    def make_grid
      @grid = Array.new(8) { Array.new(8) { :empty } }

      make_symmetrical_pieces(Bishop, 2, 0)
      make_symmetrical_pieces(Knight, 1, 0)
      make_symmetrical_pieces(Rook, 0, 0)
      (0..3).each do |x|
        make_symmetrical_pieces(Pawn, x, 1)
      end

      make_piece(King, 4, 0, :black)
      make_piece(King, 4, 7, :white)
      make_piece(Queen, 3, 0, :black)
      make_piece(Queen, 3, 7, :white)
    end

end
