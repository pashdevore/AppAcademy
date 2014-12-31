require 'byebug'

class Enumerables

  # returns numbers in array multiplied by two
  def multiply_by_two(arr)
    arr.map { |el| el * 2 }
  end
end

class Array

  # iterates over items in passed block
  def my_each(&prc)
    prc.call(self)
  end

  # finds median of both even and odd numbered arrays
  def find_median(arr)
    arr.sort!
    midpoint = arr.length/2

    if arr.length%2 == 0
      # even number - take average
      (arr[midpoint] + arr[midpoint - 1])/2.0
    else
      arr[midpoint]
    end
  end

  # uses inject to concatenate strings in array
  def concatenate(arr)
    arr.inject(:+)
  end
end
