require "io/console"
require "./board.rb"
require "./piece.rb"
require "byebug"

class Game

  attr_reader :board

  def initialize(size)
    @board = Board.new(size, true)
  end

  def play
    @board.render(@board.cursor)
    current_player = :white
    current_pos = nil
    start_row, start_col = nil, nil
    end_row, end_col = nil, nil

    until won?
      # byebug
      begin
        puts "#{current_player.to_s}'s turn..."
        user_input = STDIN.getch
        cur = self.board.cursor

        case user_input
          when 'w'
            cur[0] -= 1 unless cur[0] == 0
          when 'a'
            cur[1] -= 1 unless cur[1] == 0
          when 's'
            cur[0] += 1 unless cur[0] == 7
          when 'd'
            cur[1] += 1 unless cur[1] == 7
          when 'r'

            #check to see if we are selecting our end move
            if self.board[cur].nil? && start_row
              end_row, end_col = cur
              current_pos = self.board[[start_row, start_col]]
              current_pos.perform_move([end_row, end_col])

              #check to see if we can still hop opponents piece
              if current_pos.valid_jumps.empty? || (start_row - end_row).abs == 1
                current_player = current_player == :white ? :black : :white
              end

              #reset
              start_row, start_col = nil, nil

            #we must be starting
            elsif !self.board[cur].nil? && self.board[cur].color == current_player
              start_row, start_col = cur
            end
          when 'q'
            exit
          end
        rescue InvalidMoveError => e
          puts "#{e.message}"
      end
      @board.render(cur)
    end
  end

  def won?
    return true if flatten_board.all? { |piece| piece.color == :white }
    return true if flatten_board.all? { |piece| piece.color == :black }
  end

  def flatten_board
    self.board.grid.flatten.compact
  end
end

g = Game.new(8)
g.play
