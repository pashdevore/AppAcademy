require_relative 'piece'
require_relative 'sliding_piece'

class Rook < Piece

  include SlidingPiece

  def moves
    sliding_moves(ORTH)
  end

  def symbol
    @color == 'w' ? '♖' : '♜'
  end

end
