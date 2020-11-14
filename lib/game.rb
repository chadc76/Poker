require_relative 'player.rb'
require_relative 'deck.rb'

class Game
  attr_reader :pot, :deck

  def initialize
    @pot = 0
    @deck = Deck.new
  end
end