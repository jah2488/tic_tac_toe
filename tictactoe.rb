#!/usr/bin/env ruby
require 'rubygems'
require 'pry'
require 'readline'
require 'colored'
require_relative "lib/tic_tac_ruby"

class Tictactoe
  def initialize
    TicTacRuby::Menu.new
  end
end

Tictactoe.new