require_relative "deck"
require_relative "card"
require_relative "cash"

class Blackjack
  def start
    puts `clear`
    puts "~~~~~~Welcome to Blackjack~~~~~~~"
    puts ""
    puts "Place your bet. Minimum $5. You currently have $#{@@cash}."
    
    # call place_bet method and store bet as @bet
    place_bet
    sleep(1)
    # instaniate @new_deck from Deck class
    @new_deck = Deck.new
    puts `clear`
    puts "Dealing cards..."
    sleep(1.5)
    deal_two
  end

  def place_bet
    print "> $"
    @bet = gets.to_i

    # verify @bet is a number between 5 and their current total
    if @bet == 0
      # if bet is a string, return this message
      puts "Not a valid bet, please try again."
      place_bet
    elsif @bet < 5
      puts "Please bet at least $5"
      place_bet
    elsif @bet > @@cash 
      puts "You don't have that much money. Please try a lower bet."
      place_bet
    elsif @bet >= 5 && @bet <= @@cash 
      puts "Your bet of $#{@bet} has been placed"
      # subtract bet from total money
      @@cash = @@cash-@bet
    else 
      puts "Not valid input. Please try again with a number."
      place_bet
    end
  end

  def deal_two
    puts `clear`
    puts "~~~~~Your two cards:~~~~~~"
    @curr_hand = []
    @new_deck = @new_deck.shuffle_cards 
      @new_deck.take(2).each do |card|
        puts "#{card.rank} #{card.suit} (#{card.color})"
        # remove those two cards from the deck
        @new_deck.shift(2)
        @curr_hand.push([card.rank, card.suit, card.color])
    end
    dealer_hand
    find_total_player
    stand_or_hit
  end

  def dealer_hand
    @dealer_curr_hand = []
    puts ""
    puts "The dealer was dealt a "
    @new_deck.take(1).each do |card|
      puts "#{card.rank} #{card.suit} (#{card.color})"
      @new_deck.shift(1)
      @dealer_curr_hand.push([card.rank, card.suit, card.color])
    end
    puts "The dealer's other card is face down"
    @new_deck.take(1).each do |card|
      @new_deck.shift(1)
      @dealer_curr_hand.push([card.rank, card.suit, card.color])
    end
  end

  def stand_or_hit
    puts ""
    puts "Do you want to stand or hit?"
    puts "1) Stand"
    puts "2) Hit"
    user_play = gets.to_i
    if user_play == 1
      print_dealer_cards
      find_total_dealer
    elsif user_play == 2
      deal_next_card
    else
      puts "Please enter valid input"
      stand_or_hit
    end
  end

  def deal_next_card 
    puts "You were dealt:" 
    @new_deck.take(1).each do |card|
      puts "#{card.rank} #{card.suit} (#{card.color})"
      # remove one card from deck
      @new_deck.shift(1)
      @curr_hand.push([card.rank, card.suit, card.color])
    end
    puts ""
    puts "Your cards are: "
    @curr_hand.each do |card|
      puts "#{card[0]} of #{card[1]}, #{card[2]}"
    end
    find_total_player
    stand_or_hit
  end

  def deal_next_dealer_card(num) 

    if num < 17
      puts ""
      puts "Dealer has to draw a card:"
      @new_deck.take(1).each do |card|
        puts "#{card.rank} #{card.suit} (#{card.color})"
        # remove one card from deck
        @new_deck.shift(1)
        @dealer_curr_hand.push([card.rank, card.suit, card.color])
        print_dealer_cards
        find_total_dealer
      end
    else
      # call method to compare user and dealer cards
      find_winner
    end
    
  end

  def print_dealer_cards
    puts ""
    sleep(1.5)
    puts "The dealer's cards are:"
    @dealer_curr_hand.each do |card|
      puts "#{card[0]} of #{card[1]}, #{card[2]}"
    end
  end

  def find_total_player
    total_num = 0
    # total up points
    @curr_hand.each do |card|
    case card[0]
      when "A"
        total_num = total_num+11
      when "9"
        total_num = total_num+9
      when "8"
        total_num = total_num+8
      when "7"
        total_num = total_num+7
      when "6"
        total_num = total_num+6
      when "5"
        total_num = total_num+5
      when "4"
        total_num = total_num+4
      when "3"
        total_num = total_num+3
      when "2"
        total_num = total_num+2
      else
        total_num = total_num+10
      end
    end
    check_method = caller_locations(1,1)[0].label
    if check_method == "find_winner"
      return total_num 
    else
      check_bust_player(total_num)
    end
  end

  def find_total_dealer
    total_num = 0
    # total up points
    @dealer_curr_hand.each do |card|
    case card[0]
      when "A"
        total_num = total_num+11
      when "9"
        total_num = total_num+9
      when "8"
        total_num = total_num+8
      when "7"
        total_num = total_num+7
      when "6"
        total_num = total_num+6
      when "5"
        total_num = total_num+5
      when "4"
        total_num = total_num+4
      when "3"
        total_num = total_num+3
      when "2"
        total_num = total_num+2
      else
        total_num = total_num+10
      end
    end
    check_method = caller_locations(1,1)[0].label
    if check_method == "find_winner"
      return total_num 
    else
    check_bust_dealer(total_num)
    end
  end

  def check_bust_player(num)
    if num > 21
      # bet was subtracted at first, so nothing changes with @@cash variable.
      puts "Bust! You lose."
      puts "You lost $#{@bet} and now have $#{@@cash}"
      play_again
    elsif num == 21
      # add bet to total and get money back that you bet
      @@cash = @@cash+(@bet*2)
      puts ""
      puts "You got a Blackjack, you win!"
      puts "You made $#{@bet} and you now have $#{@@cash}"
      play_again
    else
      return
    end
  end

  def check_bust_dealer(num)
    if num > 21
      # add bet to total and get money back that you bet
      @@cash = @@cash+(@bet*2)
      puts "Dealer busted! You win!"
      puts "You made $#{@bet} and you now have $#{@@cash}"
      play_again
    elsif num == 21
      # bet was subtracted at first, so nothing changes with @@cash variable.
      puts "Dealer got a Blackjack, you lose!"
      puts "You lost $#{@bet} and now have $#{@@cash}"
      play_again
    else
      deal_next_dealer_card(num)
    end
  end

  def find_winner
    sleep(1)
    player_total = find_total_player
    dealer_total = find_total_dealer

    if player_total > dealer_total
      # add bet to total and get money back that you bet
      @@cash = @@cash+(@bet*2)
      puts "You win! Your cards totaled #{player_total} and the dealer's totaled #{dealer_total}"
      puts "You made $#{@bet} and you now have $#{@@cash}"
    elsif player_total == dealer_total
      # get your bet back
      @@cash = @@cash+@bet
      puts "Draw! You and the dealer both had #{player_total}"
      puts "You get your bet back"
      puts "You now have $#{@@cash}"
    else
      # bet was subtracted at first, so nothing changes with @@cash variable.
      puts "You lost! The dealer's card totaled #{dealer_total} and your card's totaled #{player_total}"
      puts "You lost $#{@bet} and now have $#{@@cash}"
    end
    play_again
  end

  def play_again 
    puts "Would you like to play again? (y/n)"
    print "> "
    play = gets.strip 
    if play == "y" || play == "Y"
      # user wants to start a new game
      start
    elsif play == "n" || play == "N"
      puts "Thanks for playing!"
      sleep(1.5)
      puts `clear`
      menu
    else
      puts "Invalid input, please type a 'y' or 'n'"
      play_again
    end
  end
end