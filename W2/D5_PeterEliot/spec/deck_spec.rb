require 'rspec'
require 'deck.rb'

describe Deck do
  let(:deck) { Deck.new }
  describe "#initialize" do
    it 'should create 52 cards' do
      expect(deck.size).to eq 52
    end

    it 'creates 52 unique cards' do
      uniq_cards = []
      deck.cards.each do |card|
        uniq_cards << card unless uniq_cards.include?(card)
      end
      expect(uniq_cards.length).to eq 52
    end
  end

  describe '#draw' do
    it 'should remove 1 card from the deck without arguments' do
      deck.draw
      expect(deck.size).to eq 51
    end

    it 'should return an Array of Cards' do
      drawn_cards = deck.draw(3)
      expect(drawn_cards).to be_an Array
      expect(drawn_cards).to all( be_a Card )
    end

    it 'should not keep returned Card in deck' do
      card = deck.draw.first
      expect(deck).not_to include card
    end

    it 'should raise an error if the deck is empty' do
      52.times { deck.draw }
      expect { deck.draw }.to raise_error RuntimeError
    end
  end

  describe "#return" do
    it "should return 1 card to the bottom of the deck" do
      card = Card.new("king", "spades")
      deck.return(card)
      expect(deck.cards.last).to eq card
    end
  end
end
