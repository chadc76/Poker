require_relative 'hand.rb'

class Player
  include Comparable

  def self.buy_in(bankroll)
    Player.new(bankroll)
  end

  attr_reader :bankroll, :hand, :current_bet, :name
  attr_accessor :board, :best_hand

  def initialize(bankroll, name)
    @bankroll = bankroll
    @current_bet = 0
    @name = name
    @board = nil
    @best_hand = nil
  end

  def deal_in(hand)
    @hand = hand
  end

  def respond_bet
    print "(c)all, (b)et, or (f)old? > "
    response = gets.chomp.downcase[0]
    case response
    when 'c' then :call
    when 'b' then :bet
    when 'f' then :fold
    else
      puts 'must be (c)all, (b)et, or (f)old'
      respond_bet
    end
  end

  def get_bet
    print "Bet (bankroll: $#{bankroll}) > "
    bet = gets.chomp.to_i
    raise 'not enough money' unless bet <= bankroll
    if (bankroll - bet) < 10
      puts "this bet leaves you with out a big blind, you must go all in"
      return bankroll
    end
    bet
  end

  def take_bet(bet)
    amount = bet - current_bet
    raise 'not enough money' unless amount <= bankroll
    @bankroll -= amount
    @current_bet = bet
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

  def <=>(other_player)
    best_hand <=> other_player.best_hand
  end

  def reset_current_bet
    @current_bet = 0
  end

  def set_board(cards)
    @board = cards
  end

  def possible_hands
    current_hand = @hand.cards
    seven_cards = @board += current_hand
    all_hands = @board.combination(5).to_a
    all_hands.map { |hand| Hand.new(hand)}      
  end

  def set_best_hand(hand)
    @best_hand = hand
  end

  def print_best_hand
    puts @best_hand.cards.map(&:to_s).join(" ")
  end

  def reset
    @board = nil
    @best_hand = nil
  end

end