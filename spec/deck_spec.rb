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
      expect(deck.count).to eq(52)
    end

    it "should be able to take in an array of cards" do
      deck = Deck.new(cards)
      expect(deck.count).to eq(3)
    end
  end

  subject(:deck) { Deck.new(cards.dup) }

  it "should not show cards" do
    expect(deck).to_not respond_to(:cards)
  end

  describe "#shuffle" do
    it "shuffles the deck of cards" do
      unshuffled = deck.dup
      deck.shuffle 
      expect(deck).to_not eq(unshuffled)
    end
  end

  describe "#take" do
    it "takes a specified number of cards off the top of the deck" do
      expect(deck.take(1)).to eq(cards[0..0])
      expect(deck.take(2)).to eq(cards[1..2])
    end

    it "removes cards from deck" do 
      deck.take(2)
      expect(deck.count).to eq(1)
    end

    it "doesn't allow you to take more cards then are left in deck" do
      deck.take(2)
      expect { deck.take(2) }.to raise_error("not enough cards")
    end
  end

  describe "#return" do 
    let(:more_cards) do
      [ double("card", :suit => :hearts, :value => :four),
        double("card", :suit => :hearts, :value => :five),
        double("card", :suit => :hearts, :value => :six) ]
    end

    it "should return cards to the deck" do
      deck.return(more_cards)
      expect(deck.count).to eq(6)
    end

    it "should add new cards to the bottom of the deck" do 
      deck.return(more_cards)
      deck.take(3)

      expect(deck.take(1)).to eq(more_cards[0..0])
      expect(deck.take(1)).to eq(more_cards[1..1])
      expect(deck.take(1)).to eq(more_cards[2..2])
    end
  end
end
