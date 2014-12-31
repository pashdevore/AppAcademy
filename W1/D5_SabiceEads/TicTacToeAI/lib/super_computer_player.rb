require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def initialize
    super
  end

  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    possible_moves = node.children

    node = possible_moves.find{ |child| child.winning_node?(mark) }
    if node.nil?
      node = possible_moves.find{ |child| !child.losing_node?(mark) }
    end

    return node.prev_move_pos if !node.nil?

    raise "The computer is too good!"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
