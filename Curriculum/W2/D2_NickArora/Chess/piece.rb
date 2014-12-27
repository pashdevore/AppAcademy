class Piece

  attr_reader :color
  attr_accessor :pos

  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @color = color
  end

  def attack_moves
    moves
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  def move_into_check?(end_pos)

    # Duplicate the board
    new_board = Board.new
    new_board.grid = @board.dup(new_board)

    # Perform the move
    new_board.move!(@pos, end_pos)

    # If in check return true
    new_board.in_check?(@color)
  end

end
