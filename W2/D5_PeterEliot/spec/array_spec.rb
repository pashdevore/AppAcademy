require "rspec"
require "array"

describe Array do
  describe "#my_uniq" do
    it "works on an empty array" do
      expect([].my_uniq).to eq []
    end
    it "works on a 1-long array" do
      expect([1].my_uniq).to eq [1]
    end
    it "works on a longer array" do
      expect([1, 2, 3, 4].my_uniq).to eq [1, 2, 3, 4]
    end
    it "works on a simple array with dupes" do
      expect([1, 1].my_uniq).to eq [1]
    end
    it "works on a complicated array with dupes" do
      arr = [1, 2, 3, 4, 3, 5, 5, 1]
      expect(arr.my_uniq).to eq [1, 2, 3, 4, 5]
    end
  end

  describe "#two_sum" do
    it "works on an empty array" do
      expect([].two_sum).to eq []
    end

    it "finds a single pair of indexes" do
      expect([-2, 0, 2].two_sum).to eql [[0, 2]]
    end

    it "finds a single pair of indexes" do
      expect([-2, 1, -1, 0, 0, 2].two_sum).to eql [[0, 5], [1, 2], [3, 4]]
    end
  end

  describe "#my_transpose" do
    it "works on an empty array" do
      expect([].my_transpose).to eq []
    end

    it "works on array with one row" do
      expect([[1, 2, 3]].my_transpose).to eq [[1], [2], [3]]
    end

    it "works on array with one column" do
      expect([[1], [2], [3]].my_transpose).to eq [[1, 2, 3]]
    end

    it "works on a 3x3 array" do
      expect([[0, 1, 2],
              [3, 4, 5],
              [6, 7, 8]].my_transpose).to eq [[0, 3, 6],
                                              [1, 4, 7],
                                              [2, 5, 8]]
    end
  end
end
