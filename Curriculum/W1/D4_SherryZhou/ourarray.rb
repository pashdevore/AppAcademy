require 'byebug'

class Array

  def my_each(&blk)
    i = 0
    while i < self.count
      blk.call(self[i])
      i += 1
    end

    self
  end

  def my_map(&blk)
    arr = []
    self.my_each do |element|
      arr << blk.call(element)
    end

    arr
  end

  def my_select(&blk)
    arr = []
    self.my_each do |el|
      arr << el if blk.call(el)
    end

    arr
  end

  def my_inject(&blk)
    # debugger
    sum = self[0]
    self.delete_at(0)

    self.my_each do |el|
      sum = blk.call(sum, el)
    end

    sum
  end

  def my_sort!(&blk)
    # debugger
    (0...self.length - 1).to_a.each do |first_number|
      (first_number + 1...self.length).to_a.each do |second_number|
        if blk.call(self[first_number], self[second_number]) == 1
          self[first_number], self[second_number] = self[second_number], self[first_number]
        end
      end
    end
    self
  end

  def my_sort(&blk)
    arr = self.dup
    arr.my_sort!(&blk)
  end
end

def eval_block(*args, &blk)
  blk.call(args)
end
