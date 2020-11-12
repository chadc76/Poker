require 'card'

describe Card do
  subject(:ace) {Card.new(:ace, :spades)}

  describe "#initialize" do
    it "sets the card value" do
      expect(ace.value).to eq(:ace)
    end

    it "sets the card suit" do
      expect(ace.suit).to eq(:spades)
    end

    it "raise an error when recieving invalid suit" do
      expect { Card.new(:ace, :wrong) }.to raise_error("illegal suit or value")
    end

    it "raise an error when recieving invalid value" do
      expect { Card.new(:wrong, :spade) }.to raise_error("illegal suit or value")
    end
  end
end
