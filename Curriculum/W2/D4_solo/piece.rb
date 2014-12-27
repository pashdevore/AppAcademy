class InvalidMoveError < StandardError
end

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

  def valid_slides
    moves = []

    SLIDING.each do |pos_type|
      new_pos = [self.pos[0] + pos_type[0], self.pos[1] + pos_type[1]]
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

    moves.select { |move| self.board[move].nil? }
  end

  def valid_jumps
    moves = []

    JUMPING.each do |pos_type|
      new_pos = [self.pos[0] + pos_type[0], self.pos[1] + pos_type[1]]
      moves << new_pos
    end

    moves = moves.select do |move|
      kill_row = (self.pos[0] + move[0]) / 2
      kill_col = (self.pos[1] + move[1]) / 2
      kill = [kill_row, kill_col]

      if !self.board[kill].nil?

        if self.color == :white && !self.king
          move[0].between?(0, self.pos[0]) && move[1].between?(0, board.size)
        elsif self.color == :black && !self.king
          move[0].between?(self.pos[0], board.size) && move[1].between?(0, board.size)
        else
          #your a king
          move[0].between?(0, board.size) && move[1].between?(0, board.size)
        end
      end
    end

    moves.select { |move| self.board[move].nil? }
  end

  def perform_slide(to)
    self.board[to] = self.board[self.pos]
    self.board[self.pos] = nil
    self.pos = to
    self.promote?
  end

  def perform_jump(to)
    # determine if kill is empty
    kill_row = (self.pos[0] + to[0]) / 2
    kill_col = (self.pos[1] + to[1]) / 2

    if self.board[[kill_row, kill_col]].nil?
      raise InvalidMoveError
    else
      self.board[to] = self.board[self.pos]
      self.board[self.pos] = nil
      self.pos = to
      self.board[[kill_row, kill_col]] = nil
      self.promote?
    end
  end

  def promote?
    #determine if piece reached back row
    if self.color == :black
      self.king = true if self.pos[0] == 7
    else
      self.king = true if self.pos[0] == 0
    end
  end

  def perform_moves!(move_seq)
  end

  # God mode for moving
  def perform_move!(to)
    self.board[to] = self.board[self.pos]
    self.board[self.pos] = nil
    self.promote?
  end

  # User mode for moving - checks for errors
  def perform_move(to)
    if self.nil?
      # invalid move!
      raise InvalidMoveError.new("Invalid Move! Your moving from an empty space!")
    elsif valid_slides.include?(to)
      perform_slide(to)
    elsif valid_jumps.include?(to)
      perform_jump(to)
    else
      # invalid move!
      raise InvalidMoveError.new("Invalid Move! Your moving to an occupied space!")
    end
  end
end
