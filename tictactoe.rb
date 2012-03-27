#!/usr/bin/env ruby
require 'rubygems'
require 'readline'
require 'bundler/setup'
Bundler.require(:default)

require_relative "lib/tic_tac_ruby"

class Tictactoe
  def initialize
    TicTacRuby::Menu.new
  end
end

Tictactoe.new
