require_relative "high-low"
require_relative "cash"
require_relative "roulette"
require_relative "helper"
$VERBOSE = nil

def init_game
  @money = Cash.new()
  @money.init_money
  @@cash = @money.curr_money
  menu
end

def menu
  puts "~~~~~Welcome to the Casino!~~~~~~"
  puts "Which game would you like to play?"
  puts "1) High/Low"
  puts "2) Roullete"
  puts "3) Check my Money"
  puts "4) Game Instructions"
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
      puts "You have $#{@@cash} to gamble"
      sleep(1.5)
      puts `clear`
      menu
    when 4
      # instructions
    else 
    puts "error"
  end
end

init_game