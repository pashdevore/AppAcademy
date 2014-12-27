require_relative 'polytreenode'
require 'byebug'

class KnightPathFinder

  attr_accessor :visited_pos
  attr_reader :board, :starting_node

  def initialize(starting_pos)
    @starting_node = PolyTreeNode.new(starting_pos)
    @board = Array.new(8) {Array.new(8)}
    @visited_pos = [starting_pos]
  end

  def find_path(end_pos)
    queue = [self.starting_node]

    until queue.empty?
      current_node = queue.shift
      current_node.children.each do |child|
        if child.value == end_pos
          child
        else
          queue << child
        end
      end
    end
  end

  def build_move_tree
    start_pos = self.starting_node.value

    queue = [start_pos]
    until queue.empty?
      current_pos = queue.shift
      new_move_positions(current_pos).each do |new_move_position|
        child_node = PolyTreeNode.new(new_move_position)
        child_node.parent = PolyTreeNode.new(current_pos)
        queue << child_node.value
      end
    end
  end

  def new_move_positions(pos)
    new_positions = []

    self.class.valid_moves(pos).each do |move|
      if !@visited_pos.include?(move)
        @visited_pos << move
        new_positions << move
      end
    end

    new_positions
  end

  def self.valid_moves(pos)
    x,y = pos

    moves = [[x + 1, y + 2],
             [x + 1, y - 2],
             [x + 2, y + 1],
             [x + 2, y - 1],
             [x - 1, y + 2],
             [x - 1, y - 2],
             [x - 2, y + 1],
             [x - 2, y - 1]]

    moves.select { |each| self.valid_move?(each) }
  end

  def self.valid_move?(pos)
    x,y = pos
    if x < 0 || y < 0 || x > 8 || y > 8
      false
    else
      true
    end
  end

end

k = KnightPathFinder.new([0,0])

k.build_move_tree
p k.find_path([6,6])
