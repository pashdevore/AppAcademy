require_relative 'board'

class Chess

  def initialize
    @board = Board.new
    @current_player = 'White'
  end

  def run
    until game_over?
      # render board
      # prompt current_player for input
      # move_player
      # swap current_player

      @board.render
    end

    puts "White has won!" if @board.checkmate?('w')
    puts "Black has won!" if @board.checkmate?('b')
  end

  def get_input
    start_pos = nil
    until is_input_valid?(start_pos)
      "#{current_player}, Enter the coordinates of the piece you wish to move (ex: A3):"
      start_pos = gets.chomp.chars
    end

    end_pos = nil
    until is_input_valid?(end_pos)
      "#{current_player}, Enter the coordinates where you'd like to place it:"
      end_pos = gets.chomp.chars
    end

    parse([start_pos, end_pos])
  end

  def parse(arr)
    start_pos, end_pos = arr

    # PARSE THIS SHIT
  end

  def is_input_valid?(input)
    return false if input.nil?
    return false if input.length != 2
    return false unless ('A'..'Z').include? input[0]
    return false unless input[1].to_i.between(0,7)
    true
  end

  def game_over?
    @board.checkmate?('w') || @board.checkmate?('b')
  end

end
