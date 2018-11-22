require_relative "deck"
require_relative "card"
require_relative "cash"

class Blackjack
  def start
    puts `clear`
    puts "~~~~~~Welcome to Blackjack~~~~~~~"
    puts "You currently have $#{@@cash}"
    sleep(2)
    @new_deck = Deck.new
    puts `clear`
    puts "Dealing cards..."
    sleep(1.5)
    deal_two
  end

  def deal_two
    puts `clear`
    puts "~~~~~Your two cards:~~~~~~"
    @curr_hand = []
    # @new_deck.display_cards
    @new_deck = @new_deck.shuffle_cards   
      @new_deck.take(2).each do |card|
        puts "#{card.rank} #{card.suit} (#{card.color})"
        @curr_hand.push([card.rank, card.suit, card.color])
    end
    stand_or_hit
  end

  def stand_or_hit
    puts "Do you want to stand or hit?"
    puts "1) Stand"
    puts "2) Hit"
    user_play = gets.to_i
    if user_play == 1
      puts "stand"
      deal_next_card
    elsif user_play == 2
      puts "stand"
      # stand
    else
      puts "Please enter valid input"
      stand_or_hit
    end
  end

  def deal_next_card 
    puts "You were dealt:" 
    @new_deck.take(1).each do |card|
      puts "#{card.rank} #{card.suit} (#{card.color})"
      @curr_hand.push([card.rank, card.suit, card.color])
    end
    binding.pry
  end
end