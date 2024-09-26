7
6
require_relative "../lib/game.rb"

describe Game do
  describe "#get_number" do
  subject(:game_get) { Game.new }
  context "when input is valid" do
      it "gets input as integer" do
        allow(subject).to receive(:gets).and_return("8\n", "0\n", "5\n", "7\n")
        min = 1
        max = game_get.width
        number = game_get.get_number(min, max, [5])
        expect(number).to eq(7)
      end
    end
  end
end
