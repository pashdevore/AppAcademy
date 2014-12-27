class Array
  def my_uniq
    result = []
    self.each do |num|
      result << num unless result.include?(num)
    end

    result
  end

  def two_sum
    result = []

    (0...self.count).each do |i|
      (i + 1...self.count).each do |j|
        result << [i, j] if self[i] + self[j] == 0
      end
    end

    result
  end

  def my_transpose
    transposed_arr = []
    return transposed_arr if self.empty?
    (0...self[0].length).each do |i|
      transposed_arr[i] = []
      (0...self.length).each do |j|
        transposed_arr[i] << self[j][i]
      end
    end

    return transposed_arr
  end
end
