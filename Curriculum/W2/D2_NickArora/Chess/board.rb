# encoding: utf-8
require_relative 'piece'
require_relative 'rook'
require_relative 'bishop'
require_relative 'king'
require_relative 'queen'
require_relative 'knight'
require_relative 'pawn'

class EmptyPosError < ArgumentError
end

class InvalidMoveError < ArgumentError
end

class Board

  attr_accessor :grid

  def initialize(set_up_flag = true)
    @grid = set_up_board(set_up_flag)
  end

  def set_up_board(set_up_flag)

    temp_grid = Array.new(8) { Array.new(8) }

    if set_up_flag

      # Place Pieces!
      (0..7).each do |col|
        # Black pieces
        temp_grid[1][col] = Pawn.new(self, [1,col], 'b')
        temp_grid[6][col] = Pawn.new(self, [6,col], 'w')
      end

      [[0,'b'], [7,'w']].each do |row, color|
        temp_grid[row][0] = Rook.new(self, [row,0], color)
        temp_grid[row][7] = Rook.new(self, [row,7], color)

        temp_grid[row][1] = Knight.new(self, [row,1], color)
        temp_grid[row][6] = Knight.new(self, [row,6], color)

        temp_grid[row][2] = Bishop.new(self, [row,2], color)
        temp_grid[row][5] = Bishop.new(self, [row,5], color)

        temp_grid[row][3] = King.new(self, [row,3], color)
        temp_grid[row][4] = Queen.new(self, [row,4], color)
      end
    end

    temp_grid
  end

  def inspect
    nil
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, element)
    row, col = pos
    @grid[row][col] = element
  end

  def valid_move?(color, pos)
    row, col = pos

    # Within the board?
    return false if row < 0 || row > 7
    return false if col < 0 || col > 7

    current_piece = @grid[row][col]
    return true if current_piece.nil?

    # Hit its own piece?
    return false if current_piece.color == color

    true
  end

  def in_check?(color)
    king_pos = get_king_coords(color)
    possible_attacks = []

    (0..7).each do |row|
      (0..7).each do |col|
        current_piece = @grid[row][col]
        next if current_piece.nil?
        if current_piece.color != color
          possible_attacks += current_piece.attack_moves
        end
      end
    end

    possible_attacks.uniq.include?(king_pos)
  end

  def checkmate?(color)
    moves_list = []

    (0..7).each do |row|
      (0..7).each do |col|
        current_piece = @grid[row][col]
        next if current_piece.nil?
        if current_piece.color == color
          moves_list += current_piece.valid_moves
        end
      end
    end

    return true if moves_list.empty?
    false
  end

  def get_king_coords(color)
    king = nil
    (0..7).each do |row|
      (0..7).each do |col|
        current_piece = @grid[row][col]
        next if current_piece.nil?
        if current_piece.is_a?(King) && current_piece.color == color
          king = current_piece
        end
      end
    end

    king.pos
  end

  def perform_move(start_pos, end_pos, available_moves, current_piece)
    if available_moves.include?(end_pos)
      self[end_pos] = current_piece
      self[start_pos] = nil
      current_piece.pos = end_pos
      return true
    end
    false
  end

  def move(start_pos, end_pos)
    current_piece = self[start_pos]
    raise EmptyPosError if current_piece.nil?
    if !perform_move(start_pos, end_pos, current_piece.valid_moves, current_piece)
      raise InvalidMoveError.new("Move would result in Check!")
    end
  end

  def move!(start_pos, end_pos)
    current_piece = self[start_pos]
    raise EmptyPosError if current_piece.nil?
    perform_move(start_pos, end_pos, current_piece.moves, current_piece)
  end

  def dup(other_board)
    duplicate = Array.new(8) { Array.new(8) }

    @grid.each_with_index do |row, row_index|
      row.each_with_index do |item, col_index|
        unless item.nil?
          duplicate[row_index][col_index] = item.class.new(other_board, item.pos, item.color)
        end
      end
    end

    duplicate
  end

  def render
    puts "  0 1 2 3 4 5 6 7"
    @grid.each_with_index do |row, row_index|
      print "#{row_index} "
      row.each do |item|
        if item == nil
          print "_" + " "
        else
          print item.symbol + " "
        end
      end
      puts "\n"
    end

    nil
  end
end

if __FILE__ == $0


  puts "START"
  board = Board.new(true)
  board.render

  # board[[6,0]] = Rook.new(board, [6,0], 'b')
  # board[[7,1]] = Rook.new(board, [7,1], 'b')
  # board[[2,1]] = Queen.new(board, [2,1], 'b')
  # board[[7,4]] = King.new(board, [7,4], 'w')
  board.render

  # p board[[4,2]].moves
  # p board[[4,2]].valid_moves

  # p board.checkmate?('w')


end
