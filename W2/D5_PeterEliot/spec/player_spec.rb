require "rspec"
require "player.rb"
require "deck.rb"

describe Player do
  let(:deck){ Deck.new }
  let(:player){ Player.new(Player.deal_player_in(deck)) }
  describe "#initialize" do
    it "creates player with three cards in hand and a pot of zero" do
      expect(player.hand.count).to eq 3
      expect(player.pot).to eq 0
    end
  end

  describe "#fold" do
    it "discards all cards and updates player's pot" do
      player.fold
      expect(player.hand.size).to eq 0
    end
  end
end
