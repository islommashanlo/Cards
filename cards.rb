require 'pry'


class Card
  attr_reader :name, :value, :suit

  def create_by_value(value=nil, suit=nil)
    @value = value
    @suit = find_suit(suit)
    case value
      when 2..10
        @name = "#{value}"
      when 11
        @name = "jack"
      when 12
        @name = "queen"
      when 13
        @name = "king"
      when 14
        @name = "ace"
      else 
        print "Failed to create a card with a value #{value} "
    end

  end

  def create_by_name(name=nil, suit=nil)
    @name = name.to_s.downcase
    @suit = find_suit(suit)
    case name.to_s.downcase
      when "2".."10"
        @value = name.to_i
      when "jack"
        @value = 11
      when "queen"
        @value = 12
      when "king"
        @value = 13
      when "ace"
       @value = 14
      else 
        print "Failed to create a card with a name #{name} and a suit of #{suit} \n"
    end

  end

  def find_suit(suit=nil)
    downcased_suit = suit.downcase if suit.is_a?(String) 
    if downcased_suit == "diamonds" || downcased_suit == "clubs" || downcased_suit == "hearts" || downcased_suit == "spades"
      @suit = downcased_suit
    else
      @suit = "No Suit"
    end
  end

  def compare(card=nil, suit=nil)

    if card.is_a?(Card)
      if self.value > card.value
        print "#{self.name} of #{self.suit} is larger than a #{card.name} of #{card.suit}. \n"
      elsif self.value < card.value
        print "#{self.name} of #{self.suit} is smaller than a #{card.name} of #{card.suit}. \n"
      elsif self.value == card.value
        print "#{self.name} of #{self.suit} is equal to a #{card.name} of #{card.suit}. \n"
      else
        print "#{self.name} of #{self.suit} cannot be compared to a #{card.name} of #{card.suit}. \n"
      end
    else 
      converted_cart = Card.new
      converted_cart.create_by_name(card, suit)
      if converted_cart.value != nil && self.value > converted_cart.value  && converted_cart != nil
        print "#{self.name} of #{self.suit} is larger than a #{converted_cart.name} of #{converted_cart.suit}. \n"
      elsif converted_cart.value != nil && self.value < converted_cart.value && converted_cart != nil
        print "#{self.name} of #{self.suit} is smaller than a #{converted_cart.name} of #{converted_cart.suit}. \n"
      elsif converted_cart.value != nil && self.value == converted_cart.value 
        print "#{self.name} of #{self.suit} is equal to a #{converted_cart.name} of #{converted_cart.suit}. \n"
      else
        print "#{self.name} of #{self.suit} cannot be compared to a #{converted_cart.name} of #{converted_cart.suit}. \n"
      end
    end
    
  end


end



class Deck
  @@fulldeck = []

  def self.generate
    values = (2..14).to_a
    suits = ["clubs", "diamonds", "hearts", "spades"]
    suits.each do |s| 
      values.each do |v| 
        card = Card.new
        card.create_by_value(v, s)
        @@fulldeck.push(card)
      end
    end
    @@fulldeck
  end

  def self.showdeck 
    @@fulldeck
  end

  
  def self.deal
    card = @@fulldeck.shift
    card
  end
 
  def self.return_cards(cards)
    if cards.is_a?(Array)
      cards.each do |e|
        @@fulldeck.push(e)
      end
    else
       @@fulldeck.push(cards)
    end
    @@fulldeck
  end

  def self.shuffle_deck
    @@fulldeck.shuffle!
  end
  
end

Deck.generate

def comparison_test
  Deck.shuffle_deck
  card1 = Deck.showdeck.first
  card2 = Deck.showdeck.last
  card1.compare(card2)
  card1.compare(2)
  card1.compare("QUEENs", "diamonds")
end

def test_game_highest_card
  Deck.shuffle_deck
  player1 = []
  player2 = []
  5.times do 
    player1.push(Deck.deal)
    player2.push(Deck.deal)
  end

  player1_highest_card = player1.max{|a,b| a.value <=> b.value}
  player2_highest_card = player2.max{|a,b| a.value <=> b.value}

  if player1_highest_card.value > player2_highest_card.value
    puts "Player 1 has a #{player1_highest_card.name} of #{player1_highest_card.suit} and Player 2 has a #{player2_highest_card.name} of #{player2_highest_card.suit} \n Player 1 wins "
    Deck.return_cards(player1)
    Deck.return_cards(player2)
  elsif player2_highest_card.value > player1_highest_card.value
    puts "Player 2 has a #{player2_highest_card.name} of #{player2_highest_card.suit} and Player 1 has a #{player1_highest_card.name} of #{player1_highest_card.suit} \n Player 2 wins "
    Deck.return_cards(player1)
    Deck.return_cards(player2)
  else 
    puts "Player 1 has a #{player1_highest_card.name} of #{player1_highest_card.suit} and Player 2 has a #{player2_highest_card.name} of #{player2_highest_card.suit} \n It is a draw "
    Deck.return_cards(player1)
    Deck.return_cards(player2)
  end

end

comparison_test
test_game_highest_card