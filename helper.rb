require "pry"

module AllGames
  def self.exit_current_game
    puts "Thanks for playing this game, your current balance is #{@current_cash}"
    sleep(2)
    puts `clear`
    menu
  end

  def self.get_rand 
    rand_num = rand(101)
    return rand_num
  end

end