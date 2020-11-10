require 'deck'

describe Deck do
  subject(:deck) {Deck.new}

  describe "#initialize" do
    it "sets up cards in an array" do 
      expect(deck.cards).to be_an_instance_of(Array)
    end

    it "sets each card to be a card object" do
      double(:card) {Card.new}

      deck.cards.each do |card|
        expect(card).to be_an_instance_of(Card)
      end
    end
  end

  describe "#shuffle" do
    it "shuffles the deck of cards" do
      unshuffled = deck.cards.dup
      deck.shuffle 
      expect(deck.cards).to_not eq(unshuffled)
    end
  end
end
