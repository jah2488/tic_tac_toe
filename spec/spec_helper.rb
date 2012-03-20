require "rubygems"
require "rspec"
require "pry"
require "colored"
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each do |file| 
  require File.basename(file, File.extname(file))
end

Rspec.configure do |c|
  c.mock_with :rspec
end
