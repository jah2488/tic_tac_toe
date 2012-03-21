class Menu

  #superfluous splash Screen. Adds a little pazzaz.
  #TODO: Either make this an official game_state by inhereting from
  # (non existant) core_game_state class or rework game logic into 
  # an engine class and move this into the game class as startup.

  def initialize
    menu = <<-MENU 
      #####################################
      ##                                 ##
      ##                                 ##
      ##           TIC TAC TOE           ##
      ##             in ruby             ##
      ##                                 ##
      ##                                 ##
      ##                                 ##
      ##                                 ##
      ##             GAMETYPE            ##
      ##        1) Human vs  AI          ##
      ##        2) Human vs Human        ##
      ##        3)   AI  vs  AI          ##
      ##                                 ##
      ##                                 ##
      ##              by justinherrick   ##
      ####################################
      MENU

    system('clear')
    puts menu.green

    loop do

      input = Readline.readline("[input]: ".magenta, true)
      case input
      when "1"
        @game = Game.new(1)
        @game.start
      when "2"
        @game = Game.new(2)
        @game.start
      when "3" 
        @game = Game.new(3)
        @game.start
      when "help"
        puts "\n Its Tic Tac Toe\n Try to score 3 in a row.\n Use the numbers to select a space.\n Press Enter to Finalize your move.\n 1 | 2 | 3\n-----------\n 4 | 5 | 6\n-----------\n 7 | 8 | 9\n\n"
      when "exit","quit" then exit(0) 
      else
       puts "Invalid Input. Try again".red 
      end
    end
  end
end
