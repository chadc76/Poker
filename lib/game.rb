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
end