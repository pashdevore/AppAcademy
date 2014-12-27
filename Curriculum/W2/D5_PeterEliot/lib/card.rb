class Card
  attr_reader :suit, :face_name
  FACE_VALUES = {
    'ace' => 1,
    'two' => 2,
    'three' => 3,
    'four' => 4,
    'five' => 5,
    'six' => 6,
    'seven' => 7,
    'eight' => 8,
    'nine' => 9,
    'ten' => 10,
    'jack' => 11,
    'queen' => 12,
    'king' => 13
  }

  SUITS = %w(spades clubs hearts diamonds) #all equally valued

  def self.face_names
    FACE_VALUES.keys
  end

  def self.face_numbers
    FACE_VALUES.values
  end

  def face_number
    FACE_VALUES[face_name]
  end

  def self.suits
    SUITS
  end

  def initialize(face_name, suit)
    unless FACE_VALUES.keys.include?(face_name) && SUITS.include?(suit)
      raise ArgumentError
    end

    @suit = suit
    @face_name = face_name
  end

  def inspect
    self.face_name + " " + self.suit
  end

  def == other
    [self.suit, self.face_name] == [other.suit, other.face_name]
  end
end
