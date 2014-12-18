module SteppingPiece

  def stepping_move(movements)

    possible_moves = []

    movements.each do |vert, horiz|
      cur_row, cur_col = @pos
      cur_row += vert
      cur_col += horiz

      possible_moves << [cur_row, cur_col] if @board.valid_move?(@color, [cur_row, cur_col])

    end

    possible_moves
  end

end
