require 'game'

describe Game do
  subject(:game) { Game.new }

  describe '#initialize' do
    it 'should set an empty pot' do
      expect(game.pot).to eq(0)      
    end
  end

  describe '#deck' do
    it 'should create a new deck' do
      expect(game.deck).to be_a(Deck)
    end

    it 'start with a full deck' do
      expect(game.deck.count).to eq(52)
    end
  end
end