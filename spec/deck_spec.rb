require 'deck'

describe Deck do
  describe "::all_cards" do 
    subject(:all_cards) {Deck.all_cards}
    
    it "should generate 52 cards" do
      expect(all_cards.count).to eq(52)
    end

    it "returns all cards without duplicates" do 
      expect(
        all_cards.map { |card| [card.suit, card.value] }.uniq.count
      ).to eq(all_cards.count)
    end
  end

  let(:cards) do
    [ double("card", :suit => :spades, :value => :king),
      double("card", :suit => :spades, :value => :queen),
      double("card", :suit => :spades, :value => :jack) ]
  end

  describe "#initialize" do
    it "by defualt fills cards with 52 cards" do
      deck = Deck.new 
      expect(deck.cards.count).to eq(52)
    end

    it "should be able to take in an array of cards" do
      deck = Deck.new(cards)
      expect(deck.cards.count).to eq(3)
    end
  end

  subject(:deck) { Deck.new }

  describe "#shuffle" do
    
    it "shuffles the deck of cards" do
      unshuffled = deck.cards.dup
      deck.shuffle 
      expect(deck.cards).to_not eq(unshuffled)
    end
  end
end
