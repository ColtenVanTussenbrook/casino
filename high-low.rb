require "pry"
require_relative "helper"
require_relative "cash"

class HighLow

  def start_game
    # get random number using def in helper file
    @rand_num = AllGames.get_rand
    puts `clear`
    puts "~~~~Welcome to High Low!~~~~~"
    puts "You will try to guess a number between 1 and 100."
    puts "Each guess will cost you $1. If you guess the number, you will get $10."
    puts "To give up, type 'exit' at any time:"
    guess_num
  end

  def play_high_low(guess, rand_num)
    if guess < rand_num
      @@cash = @@cash-1
      puts "Your number is too low! You lost a dollar, you now have #{@@cash}"
      guess_num
    elsif guess > rand_num
      @@cash = @@cash-1
      puts "Your number is too high! You lost a dollar, you now have #{@@cash}"
      guess_num
    else
      @@cash = @@cash+10
      puts "You guessed the right number, congratulations!"
      puts "You have $#{@@cash}"
      play_again
    end
  end

  def guess_num
    puts "Your guess:"
    print "> "
    user_input = gets.strip 
    check_input(user_input)
    guess = user_input.to_i
    play_high_low(guess, @rand_num)
  end

  def check_input(input)
    if input == "exit"
      AllGames.exit_current_game
    else
      input = input.to_i
      # checks input is between 1 and 100
      if (1..100) === input
      else
        # if it isn't, print error message and prompt for another guess
        puts "Invlalid number, please choose a number between 1 and 100"
        guess_num
      end
    end
    return input
  end

  def play_again 
    puts "Would you like to play again? (y/n)"
    print "> "
    play = gets.strip 
    if play == "y" || play == "Y"
      # user wants to start a new game
      start_game
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