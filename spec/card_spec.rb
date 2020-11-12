require 'card'

describe Card do
  subject(:king) {Card.new(:king, :spades)}

  describe "#initialize" do
    it "sets the card value" do
      expect(king.value).to eq(:king)
    end

    it "sets the card suit" do
      expect(king.suit).to eq(:spades)
    end

    it "raise an error when recieving invalid suit" do
      expect { Card.new(:king, :wrong) }.to raise_error("illegal suit or value")
    end

    it "raise an error when recieving invalid value" do
      expect { Card.new(:wrong, :spade) }.to raise_error("illegal suit or value")
    end
  end

  let(:higher_card){ Card.new(:ace, :hearts)}
  let(:same_card){ Card.new(:king, :spades)}
  let(:lower_card){ Card.new(:queen, :diamonds)}
  describe "#<=>" do

    it "should return -1 when another card value is higher" do 
      expect(king<=>higher_card).to eq(-1)
    end

    it "should return 0 when another card value is the same" do 
      expect(king<=>same_card).to eq(0)
    end

    it "should return 1 when another card value is lower" do 
      expect(king<=>lower_card).to eq(1)
    end
  end
end
