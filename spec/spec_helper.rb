require "rubygems"
require "rspec"
require "pry"
require File.expand_path("../../lib/tictactoe.rb",__FILE__)

Rspec.configure do |c|
  c.mock_with :rspec
end
