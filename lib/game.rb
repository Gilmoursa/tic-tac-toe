module TicTacToe
  class Game
    attr_accessor :available_moves
    def initialize #a simple 2D array for the tictactoe board
     @board = [[1, 2, 3],
               [4, 5, 6],
               [7, 8, 9]]
     @moves_left = 9
     @win = false
     @piece1 = nil
     @piece2 = nil
     @available_moves = [1,2,3,4,5,6,7,8,9]
      display_title  #display ascii art title
      choose_game_mode # choose human v human or human v computer
    end   

    def choose_game_mode
      game_mode = 0
      until (1..2).include?(game_mode)
        display_game_modes #display human v human / human v computer to user
        game_mode = gets.chomp.to_i
      end
      case game_mode
        when 1 # human vs human
          assign_player_pieces #ask player 1 to choose x or o, give player two what's left
          play_game(HumanPlayer.new(self, @piece1), HumanPlayer.new(self, @piece2))
        when 2 # human vs computer
          assign_player_pieces #ask player 1 to choose x or o, give player two what's left
          play_game(HumanPlayer.new(self, @piece1), ComputerPlayer.new(self, @piece2))
      end
    end

    def assign_player_pieces
      x_or_o = ['X','O']
      until x_or_o.include?(@piece1)
        display_player1_prompt
        @piece1 = gets.chomp.capitalize
      end
      x_or_o.delete(@piece1) #remove player 1's choice
      @piece2 = x_or_o.first #assign whatever piece player 1 didn't want to player 2
      display_player_assignment
    end

    def valid_move?(space) # is this move valid?
      valid = proc { |x,y| @board[x][y].class == Fixnum }
      number_to_grid(space, valid)
    end

    def place_piece(space, piece) # make a move, decrement the moves_left counter
      @moves_left -= 1
      place_space = proc { |x, y| @board[x][y] = piece }
      number_to_grid(space, place_space)
      @available_moves.delete(space)
    end

    def number_to_grid(space, proc) # converts user input to 2d array
      case space
        when 1..3
          proc.call(0, space-1)
        when 4..6
          proc.call(1, space-4)
        when 7..9
          proc.call(2, space-7)
      end
    end

    def game_over?
      if winner?
        @win = true
        return true
      end
      @moves_left == 0
    end 

    def winner? #algorithm for finding winner, if all the pieces in a row or column are the same that player is a winner. Transpose basically rotates the array by 90 degrees so first I check horizontal then vertical, finally diagonal
      @board.each           { |row| return true if row.all? { |piece| piece == "X" } }
      @board.each           { |row| return true if row.all? { |piece| piece == "O" } }
      @board.transpose.each { |column| return true if column.all? { |piece| piece == "X" } }
      @board.transpose.each { |column| return true if column.all? { |piece| piece == "O" } }
      @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] ||
        @board[2][0] == @board[1][1] && @board[1][1] == @board[0][2]
    end

    def play_game(player1, player2)
      players = [player1, player2].shuffle
      current_player = players.first
      other_player = players.last
      begin
        current_player.move
        current_player, other_player = other_player, current_player #swap player 1 and 2 for next move
      end until game_over?
      if @win
        display_board
        puts "Player #{current_player == player1 ? 2 : 1} wins!".cyan
      else
        puts "It's a draw!".red
      end
    end

    #display elements for game class, I placed them down here since there's some ascii art and pseudo-visual elements
    def display_title
      puts "\n"
      puts "\n"
      puts "    /$$$$$$$$ /$$                 /$$$$$$$$                        /$$$$$$$$                 "
      puts "   |__  $$__/|__/                |__  $$__/                       |__  $$__/                 "
      puts "      | $$    /$$  /$$$$$$$         | $$  /$$$$$$   /$$$$$$$         | $$  /$$$$$$   /$$$$$$ "
      puts "      | $$   | $$ /$$_____/         | $$ |____  $$ /$$_____/         | $$ /$$__  $$ /$$__  $$"
      puts "      | $$   | $$| $$               | $$  /$$$$$$$| $$               | $$| $$  \\ $$| $$$$$$$$"
      puts "      | $$   | $$| $$               | $$ /$$__  $$| $$               | $$| $$  | $$| $$_____/"
      puts "      | $$   | $$|  $$$$$$$         | $$ | $$$$$$$|  $$$$$$$         | $$|  $$$$$$/|  $$$$$$$"
      puts "      |__/   |__/ \\_______/         |__/  \\_______/ \\_______/        |__/ \\______/  \\_______/"
      puts "\n"       
    end

    def display_game_modes
      puts "--------------------------------------".cyan
      puts "SELECT A GAME MODE".red
      puts "--------------------------------------".cyan
      puts "1 - HUMAN vs HUMAN"
      puts "2 - HUMAN vs COMPUTER"
    end

    def display_player1_prompt
      puts "--------------------------------------".cyan
      puts "Player 1 do you want to be 'X' or 'O'?".red
      puts "--------------------------------------".cyan
    end

    def display_player_assignment
      puts "--------------------------------------".cyan
      puts "Player 1 is #{@piece1.red}"
      puts "Player 2 is #{@piece2.cyan}"
      puts "--------------------------------------".cyan
    end

    def display_board   
      rows = []
      @board.each do |row|
        rows << row.join(" | ".cyan)
      end
      puts rows.join("\n--+---+--\n".cyan)
    end
  end
end