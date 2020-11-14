require_relative 'card.rb'
require_relative 'hand.rb'

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

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  def count
    @cards.count
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

  def take(n)
    raise "not enough cards" if n > count
    @cards.shift(n)
  end

  def return(cards)
    @cards.push(*cards)
  end

  def deal_hand(n, bankrolls)
    hands = Array.new(n){Array.new}
    5.times do 
      (0..hands.length-1).each do |i|
        bankrolls[i] > 0 ? hands[i] += take(1) : hands[i] = nil
      end
    end
    hands.map do |hand|
      next if hand.nil?
      Hand.new(hand)
    end
  end
end
