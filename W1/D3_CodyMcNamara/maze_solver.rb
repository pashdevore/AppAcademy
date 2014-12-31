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

  # file reading and maze constructor methods

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

  # tree and path construction methods

  def build_move_tree
    queue = [self.starting_node]
    final_pos = determine_end

    until queue.empty?
      current_node = queue.shift
      current_pos = current_node.value

      new_move_positions(current_pos).each do |move|
        child_node = PolyTreeNode.new(move)
        child_node.parent = current_node

        child_node.g = determine_g(current_node.value, child_node.value)
        child_node.h = determine_h(current_node.value, final_pos)
        child_node.f = child_node.g + child_node.h

        queue << child_node unless queue.include?(child_node)
      end
    end
  end

  def construct_path
    # byebug
    path = [self.starting_node]
    current_node = self.starting_node
    visited = [self.starting_node]
    done = false

    until done
      f_value = 1000
      best_node = nil
      current_node.children.each do |child_node|
        if child_node.f < f_value && !visited.include?(child_node)
          best_node = child_node
          f_value = child_node.f
        end
      end

        # have to check that best_node is not nil
        # if it is we haven't got a better move
        # backtrack - add to visited, reprint, set current_node to path.last

      f_value = 1000

      if best_node.nil? && current_node != self.starting_node
        self.maze[current_node.value[0]][current_node.value[1]] = " "
        path.pop
        current_node = path.last
      elsif best_node.value == determine_end
        done = true
        write_to_file('maze_solved.txt')
      else
        f_value = 1000
        path << best_node
        visited << best_node
        current_node = best_node
        self.maze[best_node.value[0]][best_node.value[1]] = "X"
      end

    end
  end

  # helper methods

  # renders maze
  def render
    self.maze.each do |arr|
      p arr.join("")
    end
  end

  def write_to_file(file_name)
    f = File.open(file_name, 'w+')
    self.maze.each do |arr|
      f.puts arr.join("")
    end
    f.close
  end

  # determine start pos by searching for 'S' in .txt file
  def determine_start
    self.maze.each_with_index do |row, index|
      start_pos = nil
      if row.include?("S")
        start_pos = row.index("S")
        return [index, start_pos]
      end
    end
  end

  # determine end pos by searching for 'E' in .txt file
  def determine_end
    self.maze.each_with_index do |row, index|
      finish_pos = nil
      if row.include?("E")
        finish_pos = row.index("E")
        return [index, finish_pos]
      end
    end
  end

  # determine new moves from pos, checking if it is valid
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

  # returns valid moves from pos
  def valid_moves(pos)
    x, y = pos

    moves = [[x + 1, y + 0],
             [x + 0, y + 1],
             [x - 1, y + 0],
             [x + 0, y - 1]]

    moves.select { |each| valid_move?(each) }
  end

  # determines if move to pos is valid
  def valid_move?(pos)
    x,y = pos
    if x < 0 || y < 0 || x > self.maze_height || y > self.maze_width
      false
    elsif maze[x][y] == "*"
      false
    else
      true
    end
  end

  # A* helper functions

  # movement cost to move from current node to adjacent node
  def determine_g(current_pos, adj_pos)
    x1, y1 = current_pos
    x2, y2 = adj_pos

    # variation of distance formula
    ((x2-x1)**2 + (y2-y1)**2)*2
  end

  # estimated cost to move from current_node to finish_node (heuristic)
  def determine_h(current_pos, final_pos)
    # use distance formula - √(x2-x1)^2 + (y2-y1)^2
    x1, y1 = current_pos
    x2, y2 = final_pos

    Math.sqrt((x2-x1)**2 + (y2-y1)**2)
  end
end

ms = MazeSolver.new
ms.build_move_tree
ms.construct_path
