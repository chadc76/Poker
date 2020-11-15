require_relative 'player.rb'
require_relative 'deck.rb'

class Game
  attr_reader :pot, :deck, :players

  def initialize
    @pot = 0
    @deck = Deck.new
    @players = []
    @round_one = true
    @first_round_of_betting = true
  end

  def play
    system("clear")
    puts "Let's play Poker!"
    sleep(1)
    play_round until game_over?
    end_game
  end

  def play_round
    print_players_and_bankrolls
    @players.rotate! unless !@round_one
    deck.shuffle
    reset_players
    ante_up
    deal_cards
    sleep(4)
    @players.rotate!(2)
    system("clear")
    take_bets
    @players.rotate!(4)
    system("clear")
    trade_cards
    system("clear")
    take_bets
    end_round
  end

  def end_round
    show_hands
    puts 
    puts "WINNER!"
    winner.hand.print_hand 
    puts "#{winner.name} wins $#{pot} with a #{winner.hand.rank}"
    winner.receive_winnings(pot)
    @pot = 0
    return_cards
    @round_one = false
    @players.rotate!(-1)
  end

  def return_cards
    @players.each { |player| @deck.return(player.return_cards) }
  end

  def winner
    players.max
  end

  def show_hands
    puts "HANDS:"
    players.each do |player|
      next if player.folded?
      puts "#{player.name}:".ljust(12) + "   #{player.hand.rank})"
      player.hand.print_hand
    end
  end 

  def trade_cards
    @players.each_with_index do |player, i|
      next if player.folded?
      print "#{player.name}, which cards do you want to trade: "
      player.hand.print_hand
      cards = player.get_cards_to_trade
      deck.return(cards)
      player.trade_cards(cards, deck.take(cards.count))
      system("clear")
    end
  end

  def take_bets
    high_bet = @first_round_of_betting ? 10 : 0
    no_raises = false
    most_recent_better = high_bet == 0 ? nil : @players.last
    reset_current_bets unless @first_round_of_betting
    
    until no_raises
      no_raises = true
      players.each_with_index do |player, i|
        next if player.folded?
        break if most_recent_better == player || round_over?
        display_status(i, high_bet)

        begin
          response = player.respond_bet
          case response
          when :call
            add_to_pot(player.take_bet(high_bet))
          when :bet
            raise "not enough money" unless player.bankroll >= high_bet
            no_raises = false
            most_recent_better = player
            bet = player.get_bet
            raise "Bet Must be at least #{high_bet}" unless bet >= high_bet
            rs = player.take_bet(bet)
            high_bet = bet
            add_to_pot(rs)
          when :fold
            player.fold
          end
        rescue => error
          puts "#{error.message}"
          retry
        end
        system("clear")
      end
    end
    @first_round_of_betting =  @first_round_of_betting ? false : true
  end

  def display_status(index, high_bet)
    puts
    puts "Pot: $#{@pot}"
    puts "High bet: $#{high_bet}"

    players.each_with_index do |player, i|
      puts "#{player.name} has #{player.bankroll}"
    end

    puts
    puts "Current player: #{@players[index].name}"
    puts "#{@players[index].name} has bet: $#{players[index].current_bet}"
    puts "The bet is at $#{high_bet}"
    puts "#{@players[index].name}'s hand:"
    @players[index].hand.print_hand
  end

  def ante_up
    puts "Okay, let's ante up!"
    add_to_pot(@players[0].take_bet(5))
    add_to_pot(@players[1].take_bet(10))
    puts "15 was added to the pot"
    sleep(1)
    puts "Let's deal!"
  end

  def reset_players
    @players.each(&:unfold)
    reset_current_bets
  end

  def reset_current_bets
    @players.each(&:reset_current_bet)
  end

  def add_players(n, bankroll, names)
    n.times do |i|
      @players << Player.new(bankroll[i], names[i])
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

  def round_over?
    players.count {|player| !player.folded?} <= 1
  end

  def deal_cards
    hands = @deck.deal_hand(@players.count, @players.map(&:bankroll))
    hands.count.times do |i|
      @players[i].deal_in(hands[i]) unless hands[i].nil?
    end
  end

  def add_to_pot(amount)
    @pot += amount
    amount
  end

  def print_players_and_bankrolls
    puts "Current bankrolls"
    @players.each do |player|
      puts "#{player.name}:".ljust(12)  + "   $#{player.bankroll}"
    end
  end

  def end_game
    print_players_and_bankrolls
    puts "the game is over"
  end
end


def test
  g = Game.new
  players = ["Phil Hellmuth", "Doyle Brunson", "Mike McDermott"]
  g.add_players(3, [100, 100, 100], players )
  g.play
end

if __FILE__ == $PROGRAM_NAME
  test
end