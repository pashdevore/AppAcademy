# Set from Hash data type
class HashSet

  attr_accessor :store

  def initialize(set = {})
    @store = set
  end

  # inserts element into set if not already there
  def insert(el)
    self.store[el] = true if !include?(el)
  end

  # determines if set includes element
  def include?(el)
    !self.store[el].nil?
  end

  # deletes element and returns whether or not element was
  # in the set
  def delete(el)
    if include?(el)
      self.store.delete(el)
      true
    else
      false
    end
  end

  # converts the set into an array of keys & values
  def to_a
    hashed_array = []
    self.store.each do |key, value|
      hashed_array << key
      hashed_array << value
    end

    hashed_array
  end

  # joins two sets' keys and values
  def union(set)
    joined_set = HashSet.new
    # iterate through first set and insert values
    # into joined_set
    self.store.each do |key, value|
      joined_set.insert(key)
    end

    # iterate through second set
    set.store.each do |key, value|
      joined_set.insert(key)
    end

    joined_set
  end

  # joins to sets' keys and values iff both sets include
  # the key
  def intersect(set)
    joined_set = HashSet.new

    self.store.each do |key, value|
      joined_set.insert(key) if set.include?(key)
    end

    joined_set
  end
end
