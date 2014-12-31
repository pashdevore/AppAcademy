def stock_picker(prices)
  best_val = 0
  best_pair = [0, 0]

  (0...prices.length).each do |i|
    (i...prices.length).each do |j|
      buy = prices[i]
      sell = prices[j]
      if sell - buy > best_val
        best_pair = [i, j]
        best_val = sell - buy
      end
    end
  end

  best_pair
end
