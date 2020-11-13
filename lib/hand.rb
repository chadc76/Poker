class Hand
  attr_reader :cards

  def initialize(cards)
    raise "Must be five cards" if cards.length != 5
    @cards = cards
  end

  def trade_cards(old_cards, new_cards)
    raise 'must have five cards' unless old_cards.length == new_cards.length
    raise 'cannot discard unowned card' unless has_cards?(old_cards)
    take_cards(new_cards) && discard_cards(old_cards) && sort!
    old_cards
  end

  private

  def sort!
    @cards.sort!
  end

  def take_cards(new_cards)
    @cards += new_cards
  end

  def discard_cards(old_cards)
    @cards.reject!{|card| old_cards.include?(card)}
  end

  def has_cards?(old_cards)
    old_cards.all?{|card| @cards.include?(card)}
  end
end

