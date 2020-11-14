class Player
  include Comparable

  def self.buy_in(bankroll)
    Player.new(bankroll)
  end

  attr_reader :bankroll, :hand, :current_bet

  def initialize(bankroll)
    @bankroll = bankroll
    @current_bet = 0
  end

  def deal_in(hand)
    @hand = hand
  end

  def take_bet(bet)
    amount = bet - current_bet
    raise 'not enough money' unless amount <= bankroll
    @bankroll -= amount
    @current_bet = amount
    amount
  end

  def receive_winnings(money)
    @bankroll += money
  end

  def return_cards
    cards = hand.cards
    @hand = nil
    cards
  end

  def fold
    @folded = true
  end

  def unfold
    @folded = false
  end

  def folded?
    @folded
  end

end