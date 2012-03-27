require "spec_helper"

describe TicTacRuby::Menu do

  let(:game_menu) do
    TicTacRuby::Menu.new
  end

  context ".menu" do
    it "should return menu string" do
      game_menu.menu.should be_a_kind_of String
    end
  end
end