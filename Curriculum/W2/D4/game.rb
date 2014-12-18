require "io/console"
require "./board.rb"
require "./piece.rb"
require "byebug"

class Game

  attr_reader :board

  def initialize
    @board = Board.new(true)
  end

  def play
    @board.render(@board.cursor)
    current_player = :white
    current_pos = nil
    start_row, start_col = nil, nil
    end_row, end_col = nil, nil

    until won?
      # byebug
      puts "#{current_player.to_s}'s turn..."
      user_input = STDIN.getch
      c = self.board.cursor

      case user_input
        when 'w'
          self.board.cursor[0] -= 1 unless self.board.cursor[0] == 0
        when 'a'
          p c[1]
          self.board.cursor[1] -= 1 unless self.board.cursor[1] == 0
        when 's'
          p c[0]
          self.board.cursor[0] += 1 unless self.board.cursor[0] == 7
        when 'd'
          p c[1]
          self.board.cursor[1] += 1 unless self.board.cursor[1] == 7
        when 'r'
          if start_row.nil?
            start_row, start_col = self.board.cursor
          else
            end_row, end_col = self.board.cursor

            current_pos = self.board[[start_row, start_col]]

            current_pos.perform_move([end_row, end_col])

            current_player = current_player == :white ? :black : :white
            start_row, start_col = nil, nil
          end # end else
        when 'q'
          exit
      end # end of case
      @board.render(c)
    end # end of until
  end #end of function

  def won?
    return true if flatten_board.all? { |piece| piece.color == :white }
    return true if flatten_board.all? { |piece| piece.color == :black }
  end

  def flatten_board
    self.board.grid.flatten.compact
  end

end

g = Game.new
byebug
g.play
