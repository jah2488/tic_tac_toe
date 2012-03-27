#!/usr/bin/env ruby
require 'rubygems'
require 'readline'
require 'bundler/setup'
Bundler.require(:default)

require_relative "lib/tic_tac_ruby"

class Tictactoe
  def initialize
    game = TicTacRuby::Menu.new
    game.start
  end
end

Tictactoe.new
