require_relative 'polytreenode'
require 'byebug'

class KnightsTravails

  attr_reader :visited_pos
  attr_accessor :board, :starting_node

  def initialize(pos)
    @starting_node = PolyTreeNode.new(pos)
    @board = Array.new(8) { Array.new(8) }
    @visited_pos = [self.starting_node]
  end

  def find_path(end_pos)
    # create a queue and add node to explore
    queue = []
    queue << self.starting_node

    until queue.empty? || queue.first.value == end_pos
      queue.shift.children.each do |child|
        queue << child
      end
    end

    KnightsTravails.trace_path_back(queue.first).unshift(self.starting_node.value)
  end

  def self.trace_path_back(node)
    path = []

    until node.parent.nil?
      path << node.value
      node = node.parent
    end

    path.reverse
  end

  def build_move_tree
    queue = [self.starting_node]

    until queue.empty?
      current_node = queue.shift
      current_pos = current_node.value
      new_move_positions(current_pos).each do |new_move_position|
        child_node = PolyTreeNode.new(new_move_position)
        child_node.parent = current_node
        queue << child_node
      end
    end
  end

  def new_move_positions(pos)
    new_moves = []

    self.class.valid_moves(pos).each do |move|
      unless self.visited_pos.include?(move)
        new_moves << move
        self.visited_pos << move
      end
    end

    new_moves
  end

  def self.valid_moves(pos)
    x, y = pos

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
    if x < 0 || y < 0 || x > 7 || y > 7
      false
    else
      true
    end
  end
end

k = KnightsTravails.new([0, 0])
k.build_move_tree
p k.find_path([6,2])
