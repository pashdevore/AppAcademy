class HanoiGame
  attr_accessor :towers

  def initialize
    @towers = [[1, 2, 3], [], []]
  end

  def render
    towers_str = ""
    self.towers.each do |tower|
      towers_str << tower.inspect << "\n"
    end

    towers_str
  end

  def move(from, to)
    raise ArgumentError if towers[from].empty?
    if !towers[to].empty? && towers[from].first > towers[to].first
      raise ArgumentError
    end
    towers[to].unshift towers[from].shift
  end

  def won?
    full_tower = [1,2,3]
    towers[1..2].include?(full_tower)
  end
end
