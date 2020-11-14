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

  describe '#add_players' do
    it 'should create the specified amount of players' do 
      game.add_players(2, 100)
      expect(game.players.length).to eq(2)
    end

    it 'should created players' do 
      game.add_players(3, 100)
      expect(
          game.players.all?{|player| player.is_a?(Player)}
      ).to be(true)
    end

    it 'should set players bankrolls' do
      game.add_players(3, 100)
      expect(
          game.players.all? { |player| player.bankroll == 100 }
      ).to be(true)
    end
  end

  describe '#game_over?' do
    it 'should return false when players still have money' do 
      game.add_players(5,100)
      expect(game).to_not be_game_over
    end

    it 'should return true when all but oneplayer has no more money' do
      game.add_players(1, 100)
      game.add_players(4, 0)
      expect(game).to be_game_over
    end
  end
end