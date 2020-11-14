require 'hand'
require 'card'

describe Hand do
  let(:cards) {[
                Card.new(:ten, :spades),
                Card.new(:five, :hearts),
                Card.new(:ace, :hearts),
                Card.new(:two, :diamonds),
                Card.new(:two, :hearts)
  ]}

  subject(:hand) {Hand.new(cards)}

  describe "#initialize" do
    it "correctly recieves cards array" do 
      expect(hand.cards).to match_array(cards)
    end

    it "raisies error if array is not five cards" do 
      expect { Hand.new(cards[0..3]) }.to raise_error("Must be five cards")
    end
  end

  describe "#trade_cards" do 
    let(:old_cards) { cards[0..1] }
    let(:new_cards) { [Card.new(:five, :spades), Card.new(:three, :clubs)] }

    it "discards specified cards" do 
      hand.trade_cards(old_cards, new_cards)
      expect(hand.cards).to_not include(*old_cards)
    end

    it "adds new cards to hand" do
      hand.trade_cards(old_cards, new_cards) 
      expect(hand.cards).to include(*new_cards)
    end

    it 'raises an error if trade does not result in five cards' do
      expect { hand.trade_cards(old_cards, new_cards[0..0]) }.to raise_error('must have five cards')
      expect { hand.trade_cards(old_cards[0..0], new_cards) }.to raise_error('must have five cards')
    end

    it 'raises error if it tries to trade a card that is not owned' do
      expect { hand.trade_cards([Card.new(:ten, :hearts)], new_cards[0..0]) }.to raise_error('cannot discard unowned card')
    end

    it 'returns old cards' do 
      expect(hand.trade_cards(old_cards, new_cards)).to eq(old_cards)
    end
  end

  describe 'poker hands' do
    let(:royal_flush) do
      Hand.new([
        Card.new(:ace, :spades),
        Card.new(:king, :spades),
        Card.new(:queen, :spades),
        Card.new(:jack, :spades),
        Card.new(:ten, :spades)
      ])
    end

    let(:straight_flush) do
      Hand.new([
        Card.new(:eight, :spades),
        Card.new(:seven, :spades),
        Card.new(:six, :spades),
        Card.new(:five, :spades),
        Card.new(:four, :spades)
      ])
    end

    let(:four_of_a_kind) do
      Hand.new([
        Card.new(:ace, :spades),
        Card.new(:ace, :hearts),
        Card.new(:ace, :diamonds),
        Card.new(:ace, :clubs),
        Card.new(:ten, :spades)
      ])
    end

    let(:full_house) do
      Hand.new([
        Card.new(:ace, :spades),
        Card.new(:ace, :clubs),
        Card.new(:king, :spades),
        Card.new(:king, :hearts),
        Card.new(:king, :diamonds)
      ])
    end

    let(:flush) do
      Hand.new([
        Card.new(:four, :spades),
        Card.new(:seven, :spades),
        Card.new(:ace, :spades),
        Card.new(:two, :spades),
        Card.new(:eight, :spades)
      ])
    end

    let(:straight) do
      Hand.new([
        Card.new(:king, :hearts),
        Card.new(:queen, :hearts),
        Card.new(:jack, :diamonds),
        Card.new(:ten, :clubs),
        Card.new(:nine, :spades)
      ])
    end

    let(:three_of_a_kind) do
      Hand.new([
        Card.new(:three, :spades),
        Card.new(:three, :diamonds),
        Card.new(:three, :hearts),
        Card.new(:jack, :spades),
        Card.new(:ten, :spades)
      ])
    end

    let(:two_pair) do
      Hand.new([
        Card.new(:king, :hearts),
        Card.new(:king, :diamonds),
        Card.new(:queen, :spades),
        Card.new(:queen, :clubs),
        Card.new(:ten, :spades)
      ])
    end

    let(:one_pair) do
      Hand.new([
        Card.new(:ace, :spades),
        Card.new(:ace, :spades),
        Card.new(:queen, :hearts),
        Card.new(:jack, :diamonds),
        Card.new(:ten, :hearts)
      ])
    end

    let(:high_card) do
      Hand.new([
        Card.new(:two, :spades),
        Card.new(:four, :hearts),
        Card.new(:six, :diamonds),
        Card.new(:nine, :spades),
        Card.new(:ten, :spades)
      ])
    end

    let(:hand_ranks) do
      [
        :royal_flush,
        :straight_flush,
        :four_of_a_kind,
        :full_house,
        :flush,
        :straight,
        :three_of_a_kind,
        :two_pair,
        :one_pair,
        :high_card
      ]
    end

    let!(:hands) do
      [
        royal_flush,
        straight_flush,
        four_of_a_kind,
        full_house,
        flush,
        straight,
        three_of_a_kind,
        two_pair,
        one_pair,
        high_card
      ]
    end

    describe '#rank' do 
      it 'should identify the hand rank' do
        hands.each_with_index do |hand, i|
          expect(hand.rank).to eq(hand_ranks[i])
        end
      end

      context 'when straight' do
        let(:ace_straight) do
          Hand.new([
            Card.new(:ace, :hearts),
            Card.new(:two, :spades),
            Card.new(:three, :hearts),
            Card.new(:four, :hearts),
            Card.new(:five, :hearts)
          ])
        end

        it 'should let the ace be the low card in a straight' do 
          expect(ace_straight.rank).to eq(:straight)
        end
      end
    end
  end
end
