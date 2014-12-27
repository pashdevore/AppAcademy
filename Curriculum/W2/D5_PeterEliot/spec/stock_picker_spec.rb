require "rspec"
require "stock_picker"

describe "#stock_picker" do
  it 'works on a 1-long array' do
    expect(stock_picker [5]).to eq [0, 0]
  end

  it 'works on ascending array' do
    expect(stock_picker [1, 2, 3, 4, 5]).to eq [0, 4]
  end

  it 'works on decending array' do
    arr = stock_picker [5, 4, 3, 2, 1]
    expect(arr[0]).to eq(arr[1])
  end

  it 'works on array with random values' do
    expect(stock_picker([3, 1, 6, 13, 4, 8, 0, 11])).to eq [1, 3]
  end
end
