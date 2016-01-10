require_relative "./player.rb"

module TicTacToe
  class HumanPlayer < Player #human player inherits from player
    def initialize(game, piece)
      super(game, piece)
    end

    def move
      @game.display_board
      puts "--------------------------------------".cyan
      puts "Choose a space for your piece".red
      puts "--------------------------------------".cyan
      space = gets.chomp.to_i
      until @game.valid_move?(space)
        puts "--------------------------------------".cyan
        puts "Invalid move. Please try again.".red
        puts "--------------------------------------".cyan
        space = gets.chomp.to_i
      end
      @game.place_piece(space, @piece)
    end
  end
end