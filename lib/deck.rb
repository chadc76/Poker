require_relative './card'

class Deck

  def self.all_cards
    deck = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        deck << Card.new(value, suit)
      end
    end
    deck
  end

  attr_reader :cards

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  def shuffle
    shuffled = []
    until @cards.empty?
      card = @cards.sample
      @cards.delete(card)
      shuffled << card
    end
    @cards = shuffled
  end
end
