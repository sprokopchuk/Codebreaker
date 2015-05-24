module Codebreaker
  class Game
    def initialize
      @secret_code, @arr_code, @revealed_nums, @turns, @hint = "", [], "", 5, true
    end
    def start
      @secret_code, @arr_code, @revealed_nums, @turns, @hint = "", [], "", 5, true
      4.times { @secret_code << rand(1..6).to_s }
    end

    attr_reader :revealed_nums, :turns, :hint

    def guess(code)
      return "You lose! Secret code was #{@secret_code}." if @turns == 0
      raise ArgumentError, "must be four numbers" unless code.to_s.size == 4
      @revealed_nums = ""
      @turns -= 1
      code = code.to_s
      @arr_code = @secret_code.chars
      a_code = code.chars
      a_code.each_index do |i|
        if a_code[i] == @arr_code[i]
         @revealed_nums << "+"
         a_code[i] = "*"
         @arr_code[i] = "+"
        end
      end

      a_code.each_index do |i|
        j = @arr_code.find_index {|char| char == a_code[i] }
        unless j.nil?
          if @arr_code[j] == a_code[i]
            @revealed_nums << "-"
            @arr_code[j] = "+"
            a_code[i] = "*"
          end
        end
      end
      @revealed_nums == "++++" ? "You win!" : @revealed_nums
    end

    def use_hint
      hint_num = nil
      if @hint
        @arr_code.each { |i| hint_num = @arr_code[i] unless @arr_code[i] == "+" }
        @hint = false
        hint_num
      else
        @hint
      end
    end
  end
end
