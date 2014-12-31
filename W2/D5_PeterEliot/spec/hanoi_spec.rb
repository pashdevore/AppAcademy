require "rspec"
require "hanoi"

describe HanoiGame do
  let(:game) { HanoiGame.new }

  describe '#render' do
    it 'renders the initial board state' do
      expect(game.render).to eq("[1, 2, 3]\n[]\n[]\n")
    end
  end

  describe '#move' do
    it 'handles a single move' do
      game.move(0, 1)
      expect(game.towers).to eq([[2, 3], [1], []])
    end

    it 'errors when moving from empty stack' do
      expect { game.move(1, 0) }.to raise_error(ArgumentError)
    end

    it 'errors when adding large block on top of small' do
      game.move(0, 1)
      expect { game.move(0, 1) }.to raise_error(ArgumentError)
    end

    it 'handles multiple moves' do
      game.move(0, 1)
      game.move(0, 2)
      game.move(1, 2)
      expect(game.towers).to eq [[3], [], [1, 2]]
    end
  end

  describe '#won?' do
    it 'returns false when no moves have been made' do
      expect(game.won?).to eq false
    end

    it "returns false when game isn't complete" do
      game.move(0, 1)
      expect(game.won?).to eq false
    end

    it "returns false when game isn't complete" do
      game.move(0, 1)
      game.move(0, 2)
      game.move(1, 2)
      game.move(0, 1)
      game.move(2, 0)
      game.move(2, 1)
      game.move(0, 1)
      expect(game.towers).to eq [[], [1, 2, 3], []]
      expect(game.won?).to eq true
    end
  end
end
