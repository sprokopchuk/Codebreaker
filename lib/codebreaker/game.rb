module Codebreaker
  class Game
    def initialize
      @secret_code, @revealed_nums, @turns, @hint = "", "", 5, 1
    end
    def start
      @secret_code, @revealed_nums, @turns, @hint = "", "", 5, 1
      4.times { @secret_code << rand(1..6).to_s }
      "Start the new game!"
    end

    attr_reader :secret_code, :revealed_nums, :turns, :hint

    def guess(code)
      return "You lose! Secret code was #{@secret_code}." if over?
      raise ArgumentError, "must be four numbers" unless code.to_s.size == 4
      @revealed_nums = ""
      @turns -= 1
      code = code.to_s
      (0...4).each do |i|
        if @secret_code.include?(code[i])
          @secret_code[i] == code[i] ? @revealed_nums << "+" : @revealed_nums << "-"
        end
      end
      win? ? "You win!" : @revealed_nums
    end

    def use_hint
      hint_num = nil
      if @hint == 1
        (0...4).each do |i|
          hint_num = @secret_code[i] unless @revealed_nums[i] == "+"
        end
        @hint = 0
        hint_num
      else
        false
      end
    end

    def over?
      @turns == 0
    end

    def win?
      @revealed_nums == "++++"
    end

  end
end
