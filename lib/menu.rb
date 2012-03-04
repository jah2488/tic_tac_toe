require 'rubygems'
require 'pry'
require 'readline'
require 'colored'
require_relative 'game'
require_relative 'menu'
require_relative 'player'
require_relative 'board'
require_relative 'ai'

class Menu

  attr_accessor :game_type, :game

  MENU = 
"#####################################
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
#####################################".green

  system('clear')
  puts MENU
  loop do

    input = Readline.readline("[input]: ".magenta, true)
    case input
    when "1" then Game.new(1)
    when "2" then Game.new(2)
    when "3" then Game.new(3)
    when "exit" then exit(0) 
    else
     puts "Try again".red 
    end
  end
end
