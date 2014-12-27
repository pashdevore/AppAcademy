require "hand.rb"

class Player
  attr_accessor :hand, :pot

  def self.deal_player_in(deck)
    Player.new(deck.draw(3))
  end

  def initialize(hand)
    @hand = hand
    @pot = 0
  end

  def fold
    @hand.each do |card|
      
    end
  end

  def count
    @hand.count
  end
end
