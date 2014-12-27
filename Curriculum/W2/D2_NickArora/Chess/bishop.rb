require_relative 'piece'
require_relative 'sliding_piece'

class Bishop < Piece

  include SlidingPiece

  def moves
    sliding_moves(DIAG)
  end

  def symbol
    @color == 'w' ? '♗' : '♝'
  end

end
