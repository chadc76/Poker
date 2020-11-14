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
end