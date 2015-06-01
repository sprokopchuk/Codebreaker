module Codebreaker
 class Codegame
    def initialize(name = "Player")
      @name = name
      @game = Codebreaker::Game.new
      File.exists?("score.dat") ? @score = Marshal.load(File.open("score.dat")) : @score = []
    end

    attr_accessor :name

    def start_game
      puts @game.start
      while 1
        puts "Secret code consists of 4 numbers! Do you wanna make a guess?(y/n)"
        puts "Do you want load your score?(score)" if File.exists?("score.dat")
        puts "You wanna use a hint?(hint)" if @game.hint
        answer = gets.chomp
        case
          when answer == "y"
            puts "Make a guess!"
            code = gets.chomp
            puts @game.guess(code)
            if @game.res == "Win!"
              puts "You win!"
              puts "Do you wanna save a score?(y/n)"
              a = gets.chomp
              save_score if a == "y"
              break
            end
            if @game.res == "Lose!"
              puts "You lose!"
              puts "Do you wanna save a score?(y/n)"
              a = gets.chomp
              save_score if a == "y"
              break
            end
        when answer == "n"
          break
        when answer == "hint"
          puts @game.use_hint
        when answer == "score"
          load_score
        end
      end
    end

    def to_s
      "#{@name}|#{@game.attempts}|#{@game.instance_variable_get(:@secret_code)}|#{@game.res}\n"
    end

    def load_score(f = "score.dat")
      if File.exists?(f)
        @score = Marshal.load(File.open(f))
        @score.each do |player|
          arr_player = playyer.split("|")
          puts "Your name: #{arr_player[0]} | Number of attempts: #{arr_player[1]} | Secret code: #{arr_player[2]} | Result of the game: #{arr_player[3].strip}" if player[0] == @name
        end
      else
       "No score yet"
      end
    end

    def save_score(f = "score.dat")
      @score << to_s
      File.write(f, Marshal.dump(@score))
      "Score is saved!"
    end
  end
end
