require_relative "../lib/core_extensions.rb"
require_relative "../lib/game.rb"
require_relative "../lib/player.rb"
require_relative "../lib/humanplayer.rb"
require_relative "../lib/computerplayer.rb"

answer = ['Y','N']
while true
  TicTacToe::Game.new
  input = ""
  until answer.include?(input)
    puts "--------------------------------------".cyan
    puts "Would you care to play again?".red
    puts "    Y - YES" 
    puts "    N - NO"
    puts "--------------------------------------".cyan
    input = gets.chomp.capitalize
  end
    return if input != 'Y'
end

