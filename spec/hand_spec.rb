require 'hand'
require 'card'

describe Hand do
  let(:cards) {[
                Card.new(:ten, :spades),
                Card.new(:five, :hearts),
                Card.new(:ace, :hearts),
                Card.new(:two, :diamonds),
                Card.new(:two, :hearts)
  ]}

  subject(:hand) {Hand.new(cards)}

  describe "#initialize" do
    it "correctly recieves cards array" do 
      expect(hand.cards).to match_array(cards)
    end

    it "raisies error if array is not five cards" do 
      expect { Hand.new(cards[0..3]) }.to raise_error("Must be five cards")
    end
  end

  describe "#take" do 
    let(:throw_away) { cards[0..1] }
    let(:new_cards) { [Card.new(:five, :spades), Card.new(:three, :clubs)] }

    it "discards specified cards" do 
      expect(hand.take(throw_away, new_cards)).to_not include(*throw_away)
    end

    it "adds new cards to hand" do 
      expect(hand.take(throw_away, new_cards)).to include(*new_cards)
    end

    it 'raises an error if trade does not result in five cards' do
      expect { hand.take(throw_away, new_cards[0..0]) }.to raise_error('must have five cards')
      expect { hand.take(throw_away[0..0], new_cards) }.to raise_error('must have five cards')
    end

    it 'raises error if it tries to trade a card that is not owned' do
      expect { hand.take([Card.new(:ten, :hearts)], new_cards[0..0]) }.to raise_error('cannot discard unowned card')
    end
  end
end
