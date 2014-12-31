require "card.rb"

class Deck

  attr_accessor :size, :cards

  def initialize
    @cards = []
    Card.face_names.each do |value|
      Card.suits.each do |suit|
        @cards << Card.new(value, suit)
      end
    end
  end

  def size
    cards.count
  end

  def draw(num_cards = 1)
    raise RuntimeError if cards.empty?
    cards.pop(num_cards)
  end

  def return(card)
    @cards.push(card)
  end

  def include?(card)
    self.cards.include?(card)
  end
end
