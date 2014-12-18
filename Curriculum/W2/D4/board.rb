require 'byebug'
require 'colorize'

class Board

  attr_accessor :grid, :size

  def initialize(full_board)
    # American Checkers 8x8
    # International Draughts (Checkers) 10 x 10
      @size = 8
      @grid = setup_game(full_board)
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

  def render
    num = "  "
    (0...size).each do |n|
      num += n.to_s
      num += " "
    end
    print num.blue + "\n"
    self.grid.each_with_index do |row, row_idx|
      print row_idx.to_s.blue + " "
      row.each do |col|
        if col.nil?
          print "_ "
        elsif col.color == :black
          print "B "
        else
          print "W "
        end
      end
      print "\n"
    end
    print "\n"
  end
end
