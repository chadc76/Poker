class Player
  include Comparable

  def self.buy_in(bankroll)
    Player.new(bankroll)
  end

  attr_reader :bankroll, :hand, :current_bet, :name

  def initialize(bankroll, name)
    @bankroll = bankroll
    @current_bet = 0
    @name = name
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
    bet
  end

  def get_cards_to_trade
    print "Cards to trade? (ex. '1, 4, 5') > "
    card_indices = gets.chomp.split(', ').map(&:to_i)
    raise 'cannot trade more than three cards' unless card_indices.count <= 3
    puts
    card_indices.map { |i| hand.cards[i - 1] }
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

  def trade_cards(old_cards, new_cards)
    hand.trade_cards(old_cards, new_cards)
  end

  def <=>(other_player)
    hand <=> other_player.hand
  end

  def reset_current_bet
    @current_bet = 0
  end

end