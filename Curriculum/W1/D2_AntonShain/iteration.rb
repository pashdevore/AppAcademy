class Iteration

  # returns an array of all the factors of a number
  def factors(num)
    divisible_nums = []
    (1..num).each do |denominator|
      divisible_nums << denominator if num % denominator == 0
    end

    divisible_nums
  end

  # sorts an array via the bubble_sort algorithm
  def bubble_sort(unsorted_arr)
    sorted = false
    until sorted
      sorted = true

      (0...(unsorted_arr.count-1)).each do |index|
        if unsorted_arr[index] > unsorted_arr[index + 1]
          unsorted_arr[index], unsorted_arr[index + 1] =
          unsorted_arr[index + 1], unsorted_arr[index]

          sorted = false
        end
      end
    end

    unsorted_arr
  end

  # returns an array of all substrings of a word
  def substrings(str)
    subs = []
    (0...str.length).each do |idx|
      (idx...str.length).each do |idx2|
        subs << str[idx..idx2]
      end
    end

    subs.uniq
  end

  # returns all substrings of a word that are actual words
  def subwords(str)
    dictionary = File.readlines("dictionary.txt").map(&:chomp)

    real_words = substrings(str).select { |word| dictionary.include?(word) }

    real_words
  end
end
