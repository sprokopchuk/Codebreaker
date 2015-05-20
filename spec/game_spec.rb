require 'spec_helper'

module Codebreaker
  describe Game do
    let(:game) {Game.new}
    context "#start" do

      before do
        game.start
      end

      it "saves secret code" do
        expect(game.secret_code).not_to be_empty
      end

      it "saves 4 numbers secret code" do
        expect(game.secret_code).to have(4).items
      end

      it "saves secret code with numbers from 1 to 6" do
        expect(game.secret_code).to match(/[1-6]+/)
      end

      it "begin a new game with new secret code" do
        sec_code1 = game.secret_code
        game.start
        sec_code2 = game.secret_code
        expect(sec_code1).not_to eq(sec_code2)
      end

      it "begin a new game with 5 number of turns" do
        expect(game.turns).to eq(5)
      end

      it "begin a game with one hint for reveal one number" do
        expect(game.hint).to eq(1)
      end

      it "begin a game with 5 number turns for guessing a number" do
        game.guess(1234)
        game.guess(4321)
        turns1 = game.turns
        game.start
        turns2 = game.turns
        expect(turns1).not_to eq(turns2)
      end
    end

    context "#guess" do
      before do
        game.start
        game.instance_variable_set(:@secret_code, "6664")
      end

      it "propose a guess when number in the same position" do
        expect(game.guess(1234)).to match("$+")
      end

      it "propose a guess when number in the different position" do
        expect(game.guess(1243)).to eq("-")
      end

      it "propose a guess when number is missing in secret code" do
        expect(game.guess(1233)).to eq("")
      end

      it "propose a guess when number is longer or less than 4 characters" do
        expect{game.guess("12345")}.to raise_error(ArgumentError, "must be four numbers")
      end

      it "propose a guess when code exact match as secret code" do
        expect(game.guess(6664)).to eq("You win!")
        expect(game.revealed_nums).to eq("++++")
      end

      it "propose a guess when code exact match as secret code" do
        game.instance_variable_set(:@turns, 0)
        expect(game.guess(6654)).to eq("You lose! Secret code was #{game.instance_variable_get(:@secret_code)}.")
        expect(game.revealed_nums).to eq("")
      end

      it "propose a guess and chnage turns for reveal secret code" do
        expect{game.guess(6666)}.to change{game.turns}.from(5).to(4)
      end
    end

    context "#use_hint" do
      it "begin a game with one hint" do
        expect(game.hint).to eq(1)
      end

      it "when no hint if it is used" do
        game.use_hint
        expect(game.hint).to eq(0)
      end

      it "to reveal one of numbers in secret code" do
        expect(game.use_hint).to eq(game.instance_variable_get(:@secret_code)[0])
      end

      it "when no hint if it uses again" do
        game.use_hint
        expect(game.use_hint).to be_falsey
      end
    end
  end
end
