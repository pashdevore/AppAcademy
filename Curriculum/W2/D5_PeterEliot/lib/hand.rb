require "card"

class Hand
  attr_accessor :cards

  def initialize(cards = [])
    @cards = cards
  end

  def size
    cards.count
  end

  def add_cards(new_cards)
    self.cards += new_cards
  end

  def <=>(another_hand)
    return 1 if self.rank > another_hand.rank
    return -1 if self.rank < another_hand.rank
    return 1 if self.high_card > another_hand.high_card
    return -1 if self.high_card < another_hand.high_card
    return 0
  end
  
  def rank #higher is better
    methods = [straight_flush?,
               four_of_a_kind?,
               full_house?,
               flush?,
               straight?,
               three_of_a_kind?,
               two_pair?,
               one_pair?]

    return 1 unless methods.include?(true)
    9 - methods.index(true)
  end

  def straight_flush?
    straight? && flush?
  end

  def straight?
    faces = cards.map { |c| c.face_number }
    faces.sort!
    straight_from_first = (faces.first...faces.first + 5).to_a
    return true if faces == straight_from_first

    if faces.first == 1
      drop_ace = (faces[1]...faces[1] + 4).to_a
      return true if drop_ace == faces.drop(1)
    end

    false
  end

  def flush?
    suits = cards.map { |c| c.suit }
    suits.uniq.length == 1
  end

  def full_house?
    faces = cards.map { |c| c.face_number }
    return false if faces.uniq.count != 2
    uniq_faces = faces.uniq
    face_counts = uniq_faces.map { |face| faces.count(face) }.sort

    face_counts == [2, 3]
  end

  def four_of_a_kind?
    face_count_match? [1, 4]
  end

  def three_of_a_kind?
    face_count_match? [1, 1, 3]
  end

  def two_pair?
    face_count_match? [1, 2, 2]
  end

  def one_pair?
    face_count_match? [1, 1, 1, 2]
  end

  def face_count_match?(desired_faces_counts)
    faces = cards.map { |c| c.face_number }
    return false if faces.uniq.count != desired_faces_counts.count
    uniq_faces = faces.uniq
    face_counts = uniq_faces.map { |face| faces.count(face) }.sort

    face_counts == desired_faces_counts
  end

  def high_card
    faces = cards.map { |c| c.face_number }
    return 14 if faces.min == 1 && faces.max != 5 #hack for low-ace straight
    faces.max
  end
end
