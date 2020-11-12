class Card

  SUIT_STRINGS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  VALUES_STRINGS = {
    :two   => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }

  def self.suits
    SUIT_STRINGS.keys
  end

  def self.values
    VALUES_STRINGS.keys
  end

  def self.Royal_values
    VALUES_STRINGS.keys[-5..-1]
  end

  attr_reader :value, :suit

  def initialize(value, suit)
    unless Card.suits.include?(suit) && Card.values.include?(value)
      raise "illegal suit or value"
    end
    @value = value
    @suit = suit
  end
end
