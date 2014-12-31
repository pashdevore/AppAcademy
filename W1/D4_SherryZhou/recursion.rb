require 'byebug'

def recursive_range(start_number, end_number)
    if end_number < start_number
      []
    elsif start_number == end_number
      [end_number]
    else
      [start_number] + recursive_range(start_number + 1, end_number)
    end
  end

def sum_of_arrays_recursive(array)
  if array.length == 1
    array[0]
  else
    array.shift + sum_of_arrays_recursive(array)
  end
end

def sum_of_arrays_iterative(array)
  sum = 0
  (0...array.length).each do |index|
    sum += array[index]
  end
  sum
end

def exponentiation_v1(num, exponent)
  if exponent == 0
    1
  else
    num * exponentiation_v1(num, exponent-1)
  end
end

def exponentiation_v2(num, exponent)
  if exponent == 0
    1
  elsif exponent == 1
    num
  else
    (exponentiation_v2(num, exponent/2) * exponentiation_v2(num, exponent/2)) if exponent % 2 == 0
    num * ((exponentiation_v2(num, (exponent - 1)/2)) * (exponentiation_v2(num, (exponent - 1)/2)))
  end
end

def deep_dup(array)
  if array.class != Array
    array
  else
    copy_array = Array.new
    array.each do |element|
      copy_array << deep_dup(element)
    end
    copy_array
  end
end

def fibonacci(n)
  if n == 1 || n == 2
    1
  else
    fibonacci(n - 1) + fibonacci(n - 2)
  end
end

def binary_search(array, target)
  # array.sort!
  pivot = array.length / 2

  case array[pivot] <=> target
  when 1
    binary_search(array[0...pivot], target)
  when 0
    pivot
  when -1
    pivot + binary_search(array[pivot...array.count], target)
  end
end

# come back to merge and merge_sort!!!

def make_change(change_amount, change_options)
  if change_amount != 0
    coin_used = change_options.last
    while change_amount < change_options.last
      coin_used = change_options.pop
    end
    number_coins = change_amount / coin_used
    change_left = change_amount % coin_used
    Array.new(number_coins, coin_used) + make_change(change_left, change_options)
  else
    []
  end
end

def merge(array1, array2, merged = [])
  start1 = array1[0]
  start2 = array2[0]
  if start1 == nil
    merged = merged + array2
  elsif start2 == nil
    merged = merged + array1
  else
    if start1 < start2
      merged << array1.shift
      merge(array1, array2, merged)
    else
      merged << array2.shift
      merge(array1, array2, merged)
    end
  end
end

def merge_sort(array)
  array = array.each_slice(1).to_a unless array[0].class == Array
  if array.length == 0 || array.length == 1
    array
  else
    array.push(merge(array.shift, array.shift))
    merge_sort(array)
  end
end

def subsets(array)
  if array.length == 0
    []
  elsif array.length == 1
    [array]
  else
    last_plus_array = subsets(array[0..-2]).map{|array_previous| array_previous + [array.last]}
    subsets(array[0..-2]) + [[array.last]] + last_plus_array
  end
end
