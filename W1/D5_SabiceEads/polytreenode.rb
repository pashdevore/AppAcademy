require 'byebug'

class PolyTreeNode

  attr_accessor :parent, :children
  attr_reader :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    # debugger
    if new_parent == nil
      @parent.children.delete(self) if @parent
      @parent = nil
    elsif new_parent != @parent
      @parent.children.delete(self) if @parent
      @parent = new_parent
      new_parent.children.push(self) if !new_parent.children.include?(self)
    end
  end

  def add_child(new_child)
    new_child.parent = self
    self.children << new_child
  end

  def remove_child(dead_child)
    dead_child.parent = nil
    raise ArgumentError if dead_child.parent == nil
    self.children.delete(dead_child)
  end

  def dfs(target)
    return self if self.value == target
    self.children.each do |child|
      search_result_node = child.dfs(target)
      return search_result_node if !search_result_node.nil?
    end

    nil
  end

  def bfs(descendant)
    # create a queue and add node to explore
    queue = []
    queue << self

    until queue.empty? || queue.first.value == descendant
      queue.shift.children.each do |child|
        queue << child
      end
    end

    queue.first
  end
end
