require "pry"
require_relative "helper"
require_relative "cash"

class Roulette
  def start_roulette
    puts `clear`
    puts "Welcome to Roulette!" 
    "You currently have $#{@@cash}"
      @color_choice = AllGames.get_rand
        if @color_choice % 2 == 0
          @color_choice = 'red'
        else
          @color_choice = 'black'
    end
    bet_amount
  end

  def bet_amount
    puts "How much would you like to bet?"
    print "> "
    @bet = gets.to_i
    check_bet(@bet)
  end

  def check_bet(bet)
    if bet > @@cash 
      puts "You don't have that much money! Please try a different bet."
      bet_amount
    else
      user_guess_color_options
    end
  end

  def user_guess_color_options
    puts "Red or Black?"
    puts "1) Red"
    puts "2) Black"
    print "> "
    choice = gets.to_i
    user_color_guess(choice)
  end 

  def user_color_guess(choice)
    case choice
    when 1
      red_check
      puts "you guessed red"
    when 2
      black_check
      puts "you guessed black"
    else
      puts "Invalid Selection"
      user_guess_options
    end
  end

  def red_check
    if @color_choice == 'red'
      @@cash = @@cash+@bet
      puts "You win! You now have #{@@cash}."
      play_again
    else
      @color_choice == 'black'
      @@cash = @@cash-@bet
      puts "Try again if you dare, you now have #{@@cash}."
      play_again
    end
  end
  
  def black_check
    if @color_choice == 'black'
      @@cash = @@cash+@bet
      puts "You win! You now have #{@@cash}."
      play_again
    else
      @color_choice == 'red'
      @@cash = @@cash-@bet
      puts "You lost! You now have #{@@cash}."
      play_again
    end
  end

  def play_again 
    puts "Would you like to play again? (y/n)"
    print "> "
    play = gets.strip 
    if play == "y" || play == "Y"
      # user wants to start a new game
      sleep(0.5)
      puts `clear`
      start_roulette
    elsif play == "n" || play == "N"
      puts "Thanks for playing!"
      sleep(0.5)
      puts `clear`
      menu
    else
      puts "Invalid input, please type a 'y' or 'n'"
      play_again
    end
  end
end











# def play_again
#     puts "Would you like to play again?"
#     puts "1) Play Again"
#     puts "2) Exit"
# end

# def operator_operation
#     play_again
#     choice = gets.to_i
#     case choice
#     when 1
#       startRoulette
#     when 2
#       user_selection
#     else
#       puts "Invalid Selection"
#       operator_operation
#     end
# end