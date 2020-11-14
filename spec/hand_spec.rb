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

    describe '#<=>' do 
      it 'returns 1 for a hand with a higher rank' do 
        expect(royal_flush <=> straight_flush).to eq(1)
      end

      it 'returns -1 for a hand with a lower rank' do 
        expect(straight_flush <=> royal_flush).to eq(-1)
      end

      it 'returns 0 for identical hands' do 
        expect(royal_flush <=> royal_flush).to eq(0)
      end

      context 'when hands have the same rank (tie breaker)' do 
        context 'royal flush' do 
          let(:hearts_royal_flush) do
            Hand.new([
              Card.new(:ace, :hearts),
              Card.new(:king, :hearts),
              Card.new(:queen, :hearts),
              Card.new(:jack, :hearts),
              Card.new(:ten, :hearts)
            ])
          end

          let(:spades_royal_flush) do
            Hand.new([
              Card.new(:ace, :spades),
              Card.new(:king, :spades),
              Card.new(:queen, :spades),
              Card.new(:jack, :spades),
              Card.new(:ten, :spades)
            ])
          end

          it 'returns 0 regardless of suit' do
            expect(hearts_royal_flush <=> spades_royal_flush).to eq(0)
          end
        end

        context 'straight flush' do
          let(:straight_flush_eight) do
            Hand.new([
              Card.new(:eight, :spades),
              Card.new(:seven, :spades),
              Card.new(:six, :spades),
              Card.new(:five, :spades),
              Card.new(:four, :spades)
            ])
          end

          let(:straight_flush_nine) do
            Hand.new([
              Card.new(:nine, :spades),
              Card.new(:eight, :spades),
              Card.new(:seven, :spades),
              Card.new(:six, :spades),
              Card.new(:five, :spades)
            ])
          end

          let(:hearts_flush_nine) do
            Hand.new([
              Card.new(:nine, :hearts),
              Card.new(:eight, :hearts),
              Card.new(:seven, :hearts),
              Card.new(:six, :hearts),
              Card.new(:five, :hearts)
            ])
          end

          it 'compares based on high card' do
            expect(straight_flush_nine <=> straight_flush_eight).to eq(1)
            expect(straight_flush_eight <=> straight_flush_nine).to eq(-1)
          end

          it 'returns 0 for the same straight flush of a different suit' do
            expect(straight_flush_nine <=> hearts_flush_nine).to eq(0)
          end
        end

        context 'four of a kind' do 
          let(:ace_four) do
            Hand.new([
              Card.new(:ace, :spades),
              Card.new(:ace, :hearts),
              Card.new(:ace, :diamonds),
              Card.new(:ace, :clubs),
              Card.new(:ten, :spades)
            ])
          end

          let(:king_four) do
            Hand.new([
              Card.new(:king, :spades),
              Card.new(:king, :hearts),
              Card.new(:king, :diamonds),
              Card.new(:king, :clubs),
              Card.new(:ten, :spades)
            ])
          end

          it 'compares based on value of the four of kind cards values' do 
            expect(ace_four <=> king_four).to eq(1)
            expect(king_four <=> ace_four).to eq(-1)
          end

          let(:ace_with_two) do
            Hand.new([
              Card.new(:ace, :spades),
              Card.new(:ace, :hearts),
              Card.new(:ace, :diamonds),
              Card.new(:ace, :clubs),
              Card.new(:two, :spades)
            ])
          end

          it 'compares based on high card if same four of a kind' do 
            expect(ace_four <=> ace_with_two).to eq(1)
            expect(ace_with_two <=> ace_four).to eq(-1)
          end

          let(:ace_with_two_hearts) do
            Hand.new([
              Card.new(:ace, :spades),
              Card.new(:ace, :hearts),
              Card.new(:ace, :diamonds),
              Card.new(:ace, :clubs),
              Card.new(:two, :hearts)
            ])
          end

          it 'returns 0 when high cards are the same but a different suit' do 
            expect(ace_with_two <=> ace_with_two_hearts).to eq(0)
          end
        end

        context 'two pairs' do
          let(:two_pair_3_4) do
            Hand.new([
              Card.new(:three, :spades),
              Card.new(:three, :hearts),
              Card.new(:four, :hearts),
              Card.new(:four, :diamonds),
              Card.new(:ten, :hearts)
            ])
          end

          let(:two_pair_3_4_diamonds) do
            Hand.new([
              Card.new(:three, :spades),
              Card.new(:three, :hearts),
              Card.new(:four, :diamonds),
              Card.new(:four, :diamonds),
              Card.new(:ten, :hearts)
            ])
          end

          let(:two_pair_3_4_9) do
            Hand.new([
              Card.new(:three, :spades),
              Card.new(:three, :hearts),
              Card.new(:four, :hearts),
              Card.new(:four, :diamonds),
              Card.new(:nine, :hearts)
            ])
          end

          let(:two_pair_4_5) do
            Hand.new([
              Card.new(:five, :spades),
              Card.new(:five, :hearts),
              Card.new(:four, :hearts),
              Card.new(:four, :diamonds),
              Card.new(:ten, :hearts)
            ])
          end
          let(:two_pair_2_5) do
            Hand.new([
              Card.new(:five, :spades),
              Card.new(:five, :hearts),
              Card.new(:two, :hearts),
              Card.new(:two, :diamonds),
              Card.new(:ten, :hearts)
            ])
          end

          let(:pair_of_sixes) do
            Hand.new([
              Card.new(:six, :spades),
              Card.new(:six, :hearts),
              Card.new(:four, :hearts),
              Card.new(:five, :diamonds),
              Card.new(:ten, :hearts)
            ])
          end

          it 'should have two pair beats one pair' do 
            expect(two_pair_4_5 <=> pair_of_sixes).to eq(1)
          end

          it 'should have higher of two pairs to win' do
            expect(two_pair_4_5 <=> two_pair_3_4).to eq(1)
          end

          it 'should have higher second pair win, if high pair is the same' do 
            expect(two_pair_4_5 <=> two_pair_2_5).to eq(1)
          end

          it 'should have higher 5th card decide winner if same pairs' do
            expect(two_pair_3_4 <=> two_pair_3_4_9).to eq(1)
            expect(two_pair_3_4_9 <=> two_pair_3_4).to eq(-1)
          end
          it 'should return 0 if same card values, but different suits' do
            expect(two_pair_3_4 <=> two_pair_3_4_diamonds).to eq(0)
          end
        end

        context 'one pair' do 
          let(:ace_pair) do
            Hand.new([
              Card.new(:ace, :spades),
              Card.new(:ace, :spades),
              Card.new(:queen, :hearts),
              Card.new(:jack, :diamonds),
              Card.new(:ten, :hearts)
            ])
          end

          let(:king_pair) do
            Hand.new([
              Card.new(:king, :spades),
              Card.new(:king, :spades),
              Card.new(:queen, :hearts),
              Card.new(:jack, :diamonds),
              Card.new(:ten, :hearts)
            ])
          end

          let(:three_pair_jack_high) do
            Hand.new([
              Card.new(:three, :spades),
              Card.new(:three, :hearts),
              Card.new(:nine, :diamonds),
              Card.new(:jack, :hearts),
              Card.new(:ten, :hearts)
            ])
          end

          let(:three_pair_king_high) do
            Hand.new([
              Card.new(:three, :spades),
              Card.new(:three, :hearts),
              Card.new(:nine, :diamonds),
              Card.new(:king, :hearts),
              Card.new(:ten, :hearts)
            ])
          end

          let(:four_pair) do
            Hand.new([
              Card.new(:four, :spades),
              Card.new(:four, :hearts),
              Card.new(:ace, :diamonds),
              Card.new(:two, :hearts),
              Card.new(:three, :hearts)
            ])
          end

          it 'should compare based on pair value' do 
            expect(ace_pair <=> king_pair).to eq(1)
            expect(four_pair <=> three_pair_jack_high).to eq(1)
          end

          let(:ace_pair_king_high) do
            Hand.new([
              Card.new(:ace, :spades),
              Card.new(:ace, :spades),
              Card.new(:king, :hearts),
              Card.new(:jack, :diamonds),
              Card.new(:ten, :hearts)
            ])
          end

          it 'should compare based on high card if same pair value' do
            expect(ace_pair_king_high <=> ace_pair).to eq(1)
            expect(three_pair_king_high <=> three_pair_jack_high).to eq(1)
          end
        end

        context 'high card' do
          let(:ten_high) do
            Hand.new([
              Card.new(:two, :spades),
              Card.new(:four, :hearts),
              Card.new(:six, :diamonds),
              Card.new(:nine, :spades),
              Card.new(:ten, :spades)
            ])
          end

          let(:king_high) do
            Hand.new([
              Card.new(:two, :spades),
              Card.new(:four, :hearts),
              Card.new(:six, :diamonds),
              Card.new(:nine, :spades),
              Card.new(:king, :spades)
            ])
          end

          it 'should compare based on high card' do
            expect(king_high <=> ten_high).to eq(1)
            expect(ten_high <=> king_high).to eq(-1)
            expect(king_high <=> king_high).to eq(0)
          end
        end
      end
    end
  end
end
