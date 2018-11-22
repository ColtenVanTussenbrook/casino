require_relative "high-low"
require_relative "cash"
require_relative "roulette"
require_relative "helper"
require_relative "blackjack"
$VERBOSE = nil

def init_game
  @money = Cash.new()
  @money.init_money
  @@cash = @money.curr_money
  menu
end

def menu
  puts `clear`
  puts "~~~~~Welcome to the Casino!~~~~~~"
  puts "Which game would you like to play?"
  puts "1) High/Low"
  puts "2) Roullete"
  puts "3) Blackjack"
  puts "4) Check my Money"
  puts "5) Game Instructions"
  puts "6) Exit"
  print "> "
  choice = gets.to_i
  find_game(choice)
end

def find_game(choice)
  case choice 
    when 1
      new_game = HighLow.new()
      new_game.start_game
    when 2
      # puts "This game is currently in development, please check back later!"
      # sleep(1.5)
      # puts 'clear'
      # menu 
      new_roulette = Roulette.new()
      new_roulette.start_roulette
    when 3
      puts "Blackjack coming soon!"
      sleep(1.5)
      menu

      # new_blackjack = Blackjack.new()
      # new_blackjack.start
    when 4
      puts "You have $#{@@cash} to gamble"
      sleep(1.5)
      menu
    when 5
      puts "Instructions coming soon!"
      sleep(1.5)
      menu
    when 6
      exit
    else 
    puts "That isn't a valid option, please try again."
    sleep(1)
    menu
  end
end

init_game