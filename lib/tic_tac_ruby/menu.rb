module TicTacRuby
  class Menu

    #superfluous splash Screen. Adds a little pazzaz.
    #TODO: Either make this an official game_state by inhereting from
    # (non existant) core_game_state class or rework game logic into 
    # an engine class and move this into the game class as startup.

    def initialize
      @io = InputOutput.new
    end

    def menu
      menu = <<-MENU
        #####################################
        ##                                 ##
        ##                                 ##
        ##            TIC TAC TOE          ##
        ##              in ruby            ##
        ##                                 ##
        ##                                 ##
        ##                                 ##
        ##                                 ##
        ##             GAMETYPE            ##
        ##        1) Human vs Negamax      ##
        ##        2) Human vs Human        ##
        ##        3) AI    vs AI           ##
        ##        4) Human vs weak AI      ##
        ##        5) Help                  ##
        ##        6) Quit or Exit          ##
        ##                                 ##
        ##                                 ##
        ##              by justinherrick   ##
        #####################################
        MENU
    end

    def start
      system('clear')
      puts menu.green
      loop do |o|
         input = Readline.readline("> ".magenta, true)
        case input.downcase
        when "1"
          @game = Game.new(1)
        when "2"
          @game = Game.new(2)
        when "3" 
          @game = Game.new(3)
        when "4"
          @game = Game.new(4)
        when "help", "5"
          play_intro
        when "exit","quit", "6"
          exit(0)
        else
         @io.out "Invalid Input. Try again".red
        end
        @game.start if @game
      end
    end

    def play_intro
      line1 = "                                                                                                            Keys Top        1 | 2 | 3     "
      line2 = "             INSTRUCTIONS:       Use the numbers to select a space. Press Enter to make your move.          Keys Middle     4 | 5 | 6     "
      line3 = "                                                                OBJECTIVE:    Try to score 3 in a row.      Keys Bottom     7 | 8 | 9     "          
      i = 0
      j = 32
      while i < (line1.length - 33) do
          i += 1
          j += 1
          display = <<-DISPLAY
        #{'##'.green}#{line1[i..j].magenta}#{'##'.green}
        #{'##'.green}#{line2[i..j].magenta}#{'##'.green}
        #{'##'.green}#{line3[i..j].magenta}#{'##'.green}
        #{'#####################################'.green}
        DISPLAY
          system('clear')
          @io.out menu.green + display
          sleep(0.119)
        end
    end
    
  end
end
