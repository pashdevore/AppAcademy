require "rspec"
require "card.rb"

#suit, number

describe Card do
  describe '#initialize' do
    it 'properly initializes suit and face value' do
      card = Card.new('ace', 'spades')
      expect(card.suit).to eq 'spades'
      expect(card.face_name).to eq 'ace'
    end

    it 'raises an error with invalid arguments' do
      expect { Card.new('fake', 'card') }.to raise_error ArgumentError
    end
  end

  describe '#==' do
    it 'two of same card are equal' do
      card1 = Card.new('ace', 'spades')
      card2 = Card.new('ace', 'spades')
      expect(card1).to eq card2
    end

    it 'two different cards are not equal' do
      card1 = Card.new('ace', 'spades')
      card2 = Card.new('ace', 'clubs')
      card3 = Card.new('two', 'spades')
      expect(card1).not_to eq card2
      expect(card1).not_to eq card3
    end
  end

  describe '#face_name' do
    it 'works' do
      expect(Card.new('ace',   'spades').face_name).to eq 'ace'
      expect(Card.new('two',   'spades').face_name).to eq 'two'
      expect(Card.new('three', 'spades').face_name).to eq 'three'
      expect(Card.new('four',  'spades').face_name).to eq 'four'
      expect(Card.new('ten',   'spades').face_name).to eq 'ten'
      expect(Card.new('jack',  'spades').face_name).to eq 'jack'
      expect(Card.new('queen', 'spades').face_name).to eq 'queen'
      expect(Card.new('king',  'spades').face_name).to eq 'king'
    end
  end

  describe '#face_number' do
    it 'works' do
      expect(Card.new('ace',   'spades').face_number).to eq 1
      expect(Card.new('two',   'spades').face_number).to eq 2
      expect(Card.new('three', 'spades').face_number).to eq 3
      expect(Card.new('four',  'spades').face_number).to eq 4
      expect(Card.new('ten',   'spades').face_number).to eq 10
      expect(Card.new('jack',  'spades').face_number).to eq 11
      expect(Card.new('queen', 'spades').face_number).to eq 12
      expect(Card.new('king',  'spades').face_number).to eq 13
    end
  end

  describe '#suit' do
    it 'works' do
      expect(Card.new('ace', 'spades').suit).to eq 'spades'
      expect(Card.new('ace', 'clubs').suit).to eq 'clubs'
      expect(Card.new('ace', 'hearts').suit).to eq 'hearts'
      expect(Card.new('ace', 'diamonds').suit).to eq 'diamonds'
    end
  end
end
