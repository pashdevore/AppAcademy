require 'byebug'
require 'colorize'

class Board

  attr_accessor :grid, :size, :cursor

  def initialize(full_board)
    # American Checkers 8x8
    # International Draughts (Checkers) 10 x 10
      @size = 8
      @grid = setup_game(full_board)
      @cursor = [0,0]
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, el)
    row, col = pos
    @grid[row][col] = el
  end

  def setup_grid(size)
    self.grid = Array.new(size) { Array.new(size) }
  end

  def setup_pieces
    # byebug
    self.grid.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        pos = [row_idx, col_idx]
        if (col_idx + row_idx).odd? && row_idx < (self.size/2)-1
          self[pos] = Piece.new(:black, self, pos)
        elsif (col_idx + row_idx).odd? && row_idx > (self.size/2)
          self[pos] = Piece.new(:white, self, pos)
        end
      end
    end
  end

  def setup_game(full_board)
    if full_board
      setup_grid(self.size)
      setup_pieces
    else
      setup_grid(self.size)
    end
  end

  def render(cursor)
    system("clear")
    num = "   "
    (0...size).each do |n|
      num += n.to_s
      num += "  "
    end

    print num.blue + "\n"

    self.grid.each_with_index do |row, row_idx|
      print row_idx.to_s.blue + " "

      row.each_with_index do |el, col_idx|
        if row_idx == cursor[0] && col_idx == cursor[1]
          print "   ".on_green
        elsif el.nil? && (col_idx + row_idx).odd?
          print "   ".on_black
        elsif el.nil?
          print "   "
        elsif el.king
          print " ʘ ".green.on_black
        elsif el.color == :black
          print " ʘ ".red.on_black
        else
          print " ʘ ".white.on_black
        end
      end
      print "\n"
    end
    print "\n"
  end

  def move_cursor(pos)
    self.cursor = pos
    render(self.cursor)
  end

  def inspect
    nil
  end
end
