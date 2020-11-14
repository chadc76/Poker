module TieBreaker

  def tie_breaker(other_hand)
    case rank
    when :royal_flush
      0
    when :straight_flush, :flush, :straight, :high_card
      compare_high_card(other_hand)
    when :four_of_a_kind
      compare_set_then_high_card(4, other_hand)
    when :three_of_a_kind, :full_house
      compare_set_then_high_card(3, other_hand)
    when :two_pair
      compare_two_pair(other_hand)
    when :one_pair
        compare_set_then_high_card(2, other_hand)
    end
  end

  protected

  def compare_high_card(other_hand)
    self_reverse = self.cards.reverse
    other_hand_reverse = other_hand.cards.reverse
    (0..4).each do |i|
      own_card = self_reverse[i]
      other_card = other_hand_reverse[i]
      result = own_card <=> other_card
      return result unless result == 0
    end
    0
  end

  def compare_set_then_high_card(n, other_hand)
    set_card, other_set_card = set_card(n), other_hand.set_card(n)
    if set_card.value == other_set_card.value
      compare_high_card(other_hand)
    else
      set_card <=> other_set_card
    end
  end

  def compare_two_pair(other_hand)
    high = high_pair[0] <=> other_hand.high_pair[0]
    return high unless high == 0
    low = low_pair[0] <=> other_hand.low_pair[0]
    return low unless low == 0
    compare_high_card(other_hand)
  end

  def high_pair
    if pairs[1][0].value < pairs[0][0].value
      pairs[0]
    else
      pairs[1]
    end
  end

  def low_pair
    if pairs[0][0].value < pairs[1][0].value
      pairs[0]
    else
      pairs[1]
    end
  end 

  protected
  
  def pairs
    pairs = []
    @cards.map(&:value).uniq.each do |value|
      if card_value_count(value) == 2
        pairs << @cards.select { |card| card.value == value }
      end
    end
    pairs
  end
end