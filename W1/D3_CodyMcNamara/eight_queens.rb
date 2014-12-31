
require 'byebug'
class EightQueens

  attr_accessor :board, :current_row, :current_column

  def initialize
    @board = Array.new(8) { Array.new(8) { "___" } }
    @current_row = 0
    @current_column = 0
  end

  def run
      #
      # unless check_position(self.current_column, self.current_row)
      #   self.board[self.current_row][self.current_column] = "_Q_"
      # elsif self.current_column < 7
      #   self.current_column += 1
      # else
      #   self.board[self.current_row][self.current_column] = "___"
      #   self.current_row -= 1
      #
      # end
  end

  def check_position(x, y)
    # each queen must follow the rules
    # 1) queens can't be in same row
    # 2) queens can't be in same column
    # 3) queens can't be in same diagonal

    result = row_for(x, y) + column_for(x, y) + diagonals_for(x, y)

    if result.include?("_Q_")
      true
    else
      false
    end
  end

  def row_for(x, y)
    result = []
    (0...self.board.count).each do |idx|
      result << self.board[y][idx] unless idx == x
    end

    result
  end

  def column_for(x, y)
    result = []
    self.board.each do |arr|
      (0...self.board.count).each do |idx|
        result << self.board[idx][x] unless idx == y
      end
    end

    result
  end

  def diagonals_for(x, y)
    diagonals_down_right_for(x, y) + diagonals_down_left_for(x, y)
  end

  def diagonals_down_right_for(x, y)
    # add to both x and y
    result = []

    (1..7).each do |idx|
      next_x = x + idx
      next_y = y + idx

      if next_x > 7 && next_y > 7
        result << self.board[next_y % 8][next_x % 8]
      elsif next_x > 7 || next_y > 7
        next
      else
        result << self.board[next_y][next_x]
      end
    end

    result
  end

  def diagonals_down_left_for(x, y)
    # add to y, subtract from x
    result = []
    backtrack = [x, y]

    (1..7).each do |idx|
      next_x = x - idx
      next_y = y + idx

      # if row, column is on board
      if (next_y >= 0 && next_y < 8) && (next_x >= 0 && next_x < 8)
        result << self.board[next_y][next_x]
        backtrack.push(next_x)
        backtrack.push(next_y)
      else
        # otherwise use backtrack to add remaining
        until backtrack.empty?
          x_val = backtrack.pop
          y_val = backtrack.pop
          result << self.board[y_val][x_val] unless x_val == x && y_val == y
        end
      end
    end

    result
  end

  def render
    self.board.each do |arr|
      p arr.join(" ")
      puts "\n"
    end
  end
end

b = EightQueens.new
b.check_position(0, 0)
