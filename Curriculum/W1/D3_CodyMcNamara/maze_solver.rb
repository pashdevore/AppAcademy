require 'byebug'
require_relative 'polytreenode'

class MazeSolver

  include Math

  attr_accessor :maze, :maze_height, :maze_width, :starting_node, :visited_pos

  def initialize
    @maze_height, @maze_width = 0, 0
    @maze = construct_maze_from('maze.txt')
    @starting_node = PolyTreeNode.new(determine_start)
    @visited_pos = []
  end

  def read_file(file_name)
    file = File.open(file_name)
    arr = file.readlines
    return arr
  end

  def construct_maze_from(file_name)
    m = read_file(file_name)
    self.maze_height = m.length
    self.maze_width = m[0].length

    # construct 2d-array
    maze_arr = Array.new(self.maze_height) { Array.new(self.maze_width) }

    (0...self.maze_height).each do |line|
      (0...self.maze_width).each do |char|
        next if m[line][char] == "\n"
        maze_arr[line][char] = m[line][char]
      end
      maze_arr[line].compact!
    end

    maze_arr
  end

  def build_move_tree
    queue = [self.starting_node]
    finish = determine_end

    until queue.empty?
      current_node = queue.shift
      current_pos = current_node.value
      new_move_positions(current_pos).each do |new_move_position|
        x,y = new_move_position
        next if self.maze[x][y] != " "
        child_node = PolyTreeNode.new(new_move_position)
        child_node.g = determine_g(current_pos, child_node.value)
        child_node.h = determine_h(current_pos, finish)
        child_node.f = child_node.g + child_node.h
        child_node.parent = current_node
        queue << child_node
      end
    end
  end

  def determine_best_path
    path = [self.starting_node]
    best_f = 10000
    best_node = nil
    finish = determine_end
    visited = []

    byebug
    until path.last.value == finish
      path.last.children.each do |child|
        if child.f < best_f && !child.children.empty? && !visited.include?(child)
          best_f = child.f
          best_node = child
        end
      end

      if path.last == best_node
        visited << path.pop
      elsif !visited.include?(best_node)
        path << best_node
      end

      p path
      best_f = 10000
    end

    path
  end

  def new_move_positions(pos)
    new_moves = []

    valid_moves(pos).each do |move|
      unless self.visited_pos.include?(move)
        new_moves << move
        self.visited_pos << move
      end
    end

    new_moves
  end

  def valid_moves(pos)
    x, y = pos

    moves = [[x + 1, y + 1],
             [x + 1, y - 1],
             [x + 1, y + 0],
             [x - 1, y + 1],
             [x - 1, y - 1],
             [x - 1, y + 0],
             [x + 0, y + 1],
             [x + 0, y - 1]]

    moves.select { |each| valid_move?(each) }
  end

  def valid_move?(pos)
    x,y = pos
    if x < 0 || y < 0 || x > self.maze_width || y > self.maze_height
      false
    elsif maze[x][y] != " "
      false
    else
      true
    end
  end

  def determine_start
    self.maze.each_with_index do |row, index|
      start_pos = nil
      if row.include?("S")
        start_pos = row.index("S")
        return [index, start_pos]
      end
    end
  end

  def determine_end
    self.maze.each_with_index do |row, index|
      finish_pos = nil
      if row.include?("E")
        finish_pos = row.index("E")
        return [index, finish_pos]
      end
    end
  end

  # A* functions

  # movement cost to move from current node to adjacent node
  def determine_g(current_node, adj_node)
    x1, y1 = current_node
    x2, y2 = adj_node

    # variation of distance formula
    ((x2-x1)**2 + (y2-y1)**2)*2
  end

  # estimated cost to move from current_node to finish_node (heuristic)
  def determine_h(current_node, finish_node)
    # use distance formula - √(x2-x1)^2 + (y2-y1)^2
    x1, y1 = current_node
    x2, y2 = finish_node

    Math.sqrt((x2-x1)**2 + (y2-y1)**2)
  end
end

ms = MazeSolver.new
ms.build_move_tree
p ms.maze
p ms.determine_start
p ms.determine_end
p ms.determine_best_path
