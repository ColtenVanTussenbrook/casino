require "pry"
require_relative "helper"
require_relative "cash"

class Roulette
  def start_roulette
    puts `clear`
    puts "~~~~~Welcome to Roulette!~~~~~~" 
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
    puts "How much would you like to bet? You currently have $#{@@cash}"
    print "> $"
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
      puts "You guessed red"
      red_check
    when 2
      puts "You guessed black"
      black_check
    else
      puts "Invalid Selection"
      user_guess_options
    end
  end

  def user_color_guess(choice)
    case choice
    when 1
      puts "You guessed red"
      # red_check
      check("red")
    when 2
      puts "You guessed black"
      # black_check
      check("black")
    else
      puts "Invalid Selection"
      user_guess_options
    end
  end
  
  def check(color)
    if @color_choice == color
      @@cash = @@cash+@bet
        puts "You win! You now have $#{@@cash}."
        play_again
    else 
      @@cash = @@cash-@bet
        puts "You lost! You now have $#{@@cash}."
        play_again
    end
  end

  # def red_check
  #   if @color_choice == 'red'
  #     @@cash = @@cash+@bet
  #     puts "You win! You now have $#{@@cash}."
  #     play_again
  #   else
  #     @color_choice == 'black'
  #     @@cash = @@cash-@bet
  #     puts "You lost! You now have $#{@@cash}."
  #     play_again
  #   end
  # end
  
  # def black_check
  #   if @color_choice == 'black'
  #     @@cash = @@cash+@bet
  #     puts "You win! You now have $#{@@cash}."
  #     play_again
  #   else
  #     @color_choice == 'red'
  #     @@cash = @@cash-@bet
  #     puts "You lost! You now have $#{@@cash}."
  #     play_again
  #   end
  # end

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