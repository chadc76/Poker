require_relative 'card.rb'

class Deck
  attr_reader :cards

  def initialize
    @cards = set_cards
  end

  private
  def set_cards
    @cards = []
    suits = %w(Spades Clubs Diamonds Hearts)
    types = %w(A 2 3 4 5 6 7 8 9 10 J Q K)
    suits.each do |suit|
      types.each do |type|
        @cards << Card.new(type, suit)
      end
    end
    p @cards
  end
end
