require "rspec"
require "hand.rb"

describe Hand do
  let(:hand) { Hand.new }

  let(:straight_flush) { Hand.new [
    Card.new('ace', 'spades'),
    Card.new('two', 'spades'),
    Card.new('three', 'spades'),
    Card.new('four', 'spades'),
    Card.new('five', 'spades')
  ] }

  let(:four_of_a_kind) { Hand.new [
    Card.new('ace','spades'),
    Card.new('ace','clubs'),
    Card.new('ace','hearts'),
    Card.new('ace','diamonds'),
    Card.new('three','clubs')
  ] }

  let(:full_house) { Hand.new [
    Card.new('ace','spades'),
    Card.new('ace','clubs'),
    Card.new('ace','hearts'),
    Card.new('three','diamonds'),
    Card.new('three','clubs')
  ] }

  let(:flush) { Hand.new [
    Card.new('ace','spades'),
    Card.new('five','spades'),
    Card.new('jack','spades'),
    Card.new('two','spades'),
    Card.new('three','spades')
  ] }

  let(:high_straight) { Hand.new [
    Card.new('ace','spades'),
    Card.new('jack','clubs'),
    Card.new('queen','hearts'),
    Card.new('king','diamonds'),
    Card.new('ten','clubs')
  ] }

  let(:low_straight) { Hand.new [
    Card.new('ace','spades'),
    Card.new('two','clubs'),
    Card.new('three','hearts'),
    Card.new('four','diamonds'),
    Card.new('five','clubs')
  ] }

  let(:three_of_a_kind) { Hand.new [
    Card.new('ace','spades'),
    Card.new('ace','clubs'),
    Card.new('ace','hearts'),
    Card.new('five','diamonds'),
    Card.new('three','clubs')
  ] }

  let(:two_pair) { Hand.new [
    Card.new('ace','spades'),
    Card.new('ace','clubs'),
    Card.new('five','hearts'),
    Card.new('five','diamonds'),
    Card.new('three','clubs')
  ] }

  let(:one_pair) { Hand.new [
    Card.new('ace','spades'),
    Card.new('ace','clubs'),
    Card.new('five','hearts'),
    Card.new('jack','diamonds'),
    Card.new('three','clubs')
    ] }

  let(:ace_high) { Hand.new [
    Card.new('ace','spades'),
    Card.new('seven','clubs'),
    Card.new('nine','hearts'),
    Card.new('five','diamonds'),
    Card.new('three','clubs')
  ] }

  let(:nine_high) { Hand.new [
    Card.new('two','spades'),
    Card.new('seven','clubs'),
    Card.new('nine','hearts'),
    Card.new('five','diamonds'),
    Card.new('three','clubs')
  ] }

  let(:all_hands) { [
    straight_flush,
    four_of_a_kind,
    full_house,
    flush,
    high_straight,
    low_straight,
    three_of_a_kind,
    two_pair,
    one_pair,
    ace_high,
    nine_high
  ] }


  describe '#initialize' do
    describe 'without an argument' do
      it 'starts with 0 cards' do
        expect(hand.size).to eq 0
      end
    end

    describe 'with an argument' do
      it 'starts with the given cards' do
        full_hand = Hand.new(straight_flush.cards)
        expect(full_hand.size).to eq 5
      end
    end
  end

  describe '#add_cards' do
    describe 'should increase the size of the hand' do
      it 'by one' do
        hand.add_cards([Card.new('ace', 'spades')])
        expect(hand.size).to eq 1
      end

      it 'by three' do
        hand.add_cards([Card.new('ace', 'spades'),
                        Card.new('two', 'clubs'),
                        Card.new('jack', 'diamonds')])
        expect(hand.size).to eq 3
      end
    end
  end

  describe '#<=>' do
    it 'should return zero for two equal hands' do
      all_hands.each do |hand|
        expect(hand <=> hand).to be 0
      end
    end

    it 'should return 1 for higher hands' do
      all_hands.each_with_index do |hand1, i|
        (i+1...all_hands.length).each do |j|
          hand2 = all_hands[j]

          expect(hand1 <=> hand2).to eq 1
        end
      end
    end
  end

  describe 'rank' do
    it 'should return corresponding rank' do
      expect(straight_flush.rank).to eq 9
      expect(four_of_a_kind.rank).to eq 8
      expect(full_house.rank).to eq 7
      expect(flush.rank).to eq 6
      expect(high_straight.rank).to eq 5
      expect(low_straight.rank).to eq 5
      expect(three_of_a_kind.rank).to eq 4
      expect(two_pair.rank).to eq 3
      expect(one_pair.rank).to eq 2
      expect(ace_high.rank).to eq 1
      expect(nine_high.rank).to eq 1
    end
  end

  describe '#straight_flush?' do
    it "returns false for all other hands" do
      expect((all_hands - [straight_flush]).any? { |h| h.straight_flush? }).to be false
    end
    it "does identify straight flush" do
      expect(straight_flush.straight_flush?).to be true
    end
  end

  describe '#straight?' do
    it "returns false for all other hands" do
      expect((all_hands - [low_straight, high_straight, straight_flush]).any? { |h| h.straight? }).to be false
    end
    it "does identify straight and straight flush" do
      expect(low_straight.straight?).to be true
      expect(high_straight.straight?).to be true
      expect(straight_flush.straight?).to be true
    end
  end

  describe '#flush?' do
    it "returns false for all other hands" do
      expect((all_hands - [flush, straight_flush]).any? { |h| h.flush? }).to be false
    end
    it "does identify flush and straight flush" do
      expect(flush.flush?).to be true
      expect(straight_flush.flush?).to be true
    end
  end

  describe '#full_house?' do
    it "returns false for all other hands" do
      expect((all_hands - [full_house]).any? { |h| h.full_house? }).to be false
    end
    it "does identify full house" do
      expect(full_house.full_house?).to be true
    end
  end

  describe '#four_of_a_kind?' do
    it 'returns false for all other hands' do
      expect((all_hands - [four_of_a_kind]).any? { |h| h.four_of_a_kind? }).to be false
    end
    it "does identify four of a kind" do
      expect(four_of_a_kind.four_of_a_kind?).to be true
    end
  end

  describe '#three_of_a_kind?' do
    it 'returns false for all other hands' do
      expect((all_hands - [three_of_a_kind]).any? { |h| h.three_of_a_kind? }).to be false
    end
    it "does identify three of a kind" do
      expect(three_of_a_kind.three_of_a_kind?).to be true
    end
  end

  describe '#two_pair?' do
    it 'returns false for all other hands' do
      expect((all_hands - [two_pair]).any? { |h| h.two_pair? }).to be false
    end
    it "does identify two pair" do
      expect(two_pair.two_pair?).to be true
    end
  end

  describe '#one_pair?' do
    it 'returns false for all other hands' do
      expect((all_hands - [one_pair]).any? { |h| h.one_pair? }).to be false
    end
    it "does identify two pair" do
      expect(one_pair.one_pair?).to be true
    end
  end

  describe '#high_card' do
    it 'returns the highest card' do
      expect(nine_high.high_card).to eq 9
      expect(ace_high.high_card).to eq 14
    end
  end
end
