require 'player'

describe Player do
  subject(:player) { Player.new(100) }

  describe '::buy_in' do
    it 'should create a player' do
      expect(Player.buy_in(100)).to be_a(Player)
    end

    it 'set the players bankroll' do 
      expect(Player.buy_in(100).bankroll).to eq(100)
    end
  end

  describe '#deal_in' do
    let(:hand) { double ('hand') }
    
    it 'should set the players hand' do
      player.deal_in(hand)
      expect(player.hand).to eq(hand)
    end
  end

  describe 'take_bet' do 
    it 'should decrease bankroll by amount on first bet' do
      expect do 
        player.take_bet(10)
      end.to change { player.bankroll }.by(-10)
    end

    it 'should decrease bankroll by raise amount' do
      player.take_bet(10)
      expect do
        player.take_bet(20)
      end.to change { player.bankroll }.by(-10)
    end

    it 'should return the amount deducted' do
      expect(player.take_bet(10)).to eq(10)
    end

    it 'shoud raise error if bet is more than bankroll' do 
      expect { player.take_bet(1000) }.to raise_error('not enough money')
    end
  end
end