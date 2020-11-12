class Hand
  attr_reader :cards

  def initialize(cards)
    raise "Must be five cards" if cards.length != 5
    @cards = cards
  end

  def take(throw_away, new_cards)
    raise 'must have five cards' unless throw_away.length == new_cards.length
    raise 'cannot discard unowned card' unless throw_away.all?{|card| @cards.include?(card)}
    @cards.reject!{|card| throw_away.include?(card)}
    @cards += new_cards
  end

end

