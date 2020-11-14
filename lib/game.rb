require_relative 'player.rb'
require_relative 'deck.rb'

class Game
  attr_reader :pot, :deck, :players

  def initialize
    @pot = 0
    @deck = Deck.new
    @players = []
  end

  def add_players(n, bankroll)
    n.times do 
      @players << Player.new(bankroll)
    end
  end

  def game_over?
    bankrolls = @players.map(&:bankroll)
    money_left = 0
    bankrolls.each do |bankroll|
      money_left += 1 if bankroll > 0
    end
    money_left == 1
  end

  def deal_cards
    hands = @deck.deal_hand(@players.count, @players.map(&:bankroll))
    hands.count.times do |i|
      @players[i].deal_in(hands[i]) unless hands[i].nil?
    end
  end
end