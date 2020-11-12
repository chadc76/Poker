class Hand
  attr_reader :cards

  def initialize(cards)
    raise "Must be five cards" if cards.length != 5
    @cards = cards
  end

end

