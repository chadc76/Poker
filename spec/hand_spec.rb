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
end
