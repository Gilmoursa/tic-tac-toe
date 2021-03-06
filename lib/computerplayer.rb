require_relative "./player.rb"

module TicTacToe
  class ComputerPlayer < Player #computer player inherits from player
    def initialize(game, piece)
      super(game, piece)
    end

    # make a move by taking a random available square
    def move
      puts "The computer is playing...".cyan
      sleep(0.5) #computer "thinks" for half a second, this seemed more realistic
      return if @game.game_over?
      space = (@game.available_moves & [1,3,5,7,9]).first
      if space.nil? 
        space = @game.available_moves.first
      end
      @game.place_piece(space, @piece)
    end
  end
end