require 'card'

describe Card do
  subject(:ace) {Card.new("Ace", "Spade")}

  describe "#initialize" do
    it "sets the card type" do
      expect(ace.type).to eq("Ace")
    end

    it "sets the card suit" do
      expect(ace.suit).to eq("Spade")
    end
  end
end
