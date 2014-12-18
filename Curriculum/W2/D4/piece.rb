class Piece

  SLIDING = [1,-1].repeated_permutation(2).to_a
  JUMPING = [2,-2].repeated_permutation(2).to_a

  attr_accessor :color, :king, :board, :pos

  def initialize(color, board, pos)
    @color = color
    @king = false
    @board = board
    @pos = pos
  end

  def valid_moves
    moves = []
    # byebug
    SLIDING.each do |pos_slide|
      new_pos = [self.pos[0] + pos_slide[0], self.pos[1] + pos_slide[1]]
      moves << new_pos
    end
    moves = moves.select do |move|
      if self.color == :white && !self.king
        move[0].between?(0, self.pos[0]) && move[1].between?(0, board.size)
      elsif self.color == :black && !self.king
        move[0].between?(self.pos[0], board.size) && move[1].between?(0, board.size)
      else
        #your a king
        move[0].between?(0, board.size) && move[1].between?(0, board.size)
      end
    end

    moves
  end

  def perform_slide
    #illegal slides should return false
    if self.color == :white

    else

    end
  end

  def perform_jump
    #illegal jumps should return false
  end

  def move_diffs
    #returns directions piece can move in
  end

  def promote?
    #determine if piece reached back row
  end

  def perform_moves!(move_seq)

  end

  def perform_move!(to)
    self.board[to] = self.board[self.pos]
    self.board[self.pos] = nil
    self.board.render
  end

  def perform_move(to)
    if self.board[self.pos].nil? || !self.board[to].nil?
      raise StandardError.new("You can't move there!")
    elsif !valid_moves.include?(to)
      raise StandardError.new("Invalid move!")
    else
      # checked errors - can now move
      self.board[to] = self.board[self.pos]
      self.board[self.pos] = nil
      self.board.render
    end
  end
end
