require_relative 'piece'
require_relative 'sliding_piece'

class Queen < Piece

  include SlidingPiece

  def moves
    sliding_moves(ORTH+DIAG)
  end

  def symbol
    @color == 'w' ? '♕' : '♛'
  end

end
