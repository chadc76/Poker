require_relative 'poker_hands.rb'

class Hand
  include PokerHands

  def self.winner(hands)
    hands.sort.last
  end
  
  attr_reader :cards

  def initialize(cards)
    raise "Must be no more than 5" if cards.length > 5
    @cards = cards
    sort!
  end

  def print_hand
    puts @cards.map(&:to_s).join(" ")
  end

  private

  def sort!
    @cards.sort!
  end

  def has_cards?(old_cards)
    old_cards.all? { |card| @cards.include?(card) }
  end
end


