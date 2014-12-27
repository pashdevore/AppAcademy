class Array

  # takes an array and gives back a copy without repeats
  def my_uniq(non_uniq_array)
    return_array = []

    non_uniq_array.each do |el|
      return_array << el if !return_array.include?(el)
    end

    return_array
  end

  # determines indexes that when added result in zero
  def two_sum
    i = 0
    return_array = []
    (i...self.count - 1).each do |index_one|
      (i + 1...self.count).each do |index_two|
        el_one = self[index_one]
        el_two = self[index_two]
        if el_one != 0 && el_two != 0
          return_array << [index_one, index_two] if el_one + el_two == 0
        end
      end
    end
    return_array
  end

  # takes a row or column based array and transposes values
  def my_transpose(trans_arr)
    i, j = 0, 1
    array_copy = trans_arr.dup
    (i...trans_arr.length-1).each do |index_one|
      (j...trans_arr.length).each do |index_two|
        array_copy[index_one][index_two], array_copy[index_two][index_one] =
        array_copy[index_two][index_one], array_copy[index_one][index_two]
      end
    end
    array_copy
  end

  # given an array of stock prices each day, gives back best sell
  # and buy days
  def stock_picker(prices)
    i = 0
    diff = 0
    best_days = []
    (i...prices.length).each do |index_one|
      (i + 1...prices.length).each do |index_two|
        if prices[index_two] - prices[index_one] > diff
          diff = prices[index_two] - prices[index_one]
          best_days = [index_one, index_two]
        end
      end
    end
    best_days
  end
end
