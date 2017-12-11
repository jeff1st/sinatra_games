COLORS = ["blue", "red", "green", "yellow", "orange", "pink"]

module GameHelpers
  def is_correct?(color, index, secret)
    return true if color == secret[index]
    return false
  end

  def is_misplaced?(color, index, secret)
    return true if (secret.include?(color) && color != secret[index])
    return false
  end
end

class GameIA
include GameHelpers 

  attr_accessor :secret, :results

  def initialize
    @secret_count = Hash.new(0)
    @secret = set_secret
    @attempts = 0
    init_game
    fill_secret_count
#    ingame
  end

  def init_game
    @guess = []
    @guess_count = Hash.new(0)
    @results = ["i", "j", "k", "l"]
  end

  def ingame
    while @attempts <= 12
      4.times do
        puts "hello, make a guess"
        COLORS.each_with_index do |color, index|
          puts "#{index} - #{color}"
        end
        answer = gets.chomp
        @guess << COLORS[answer.to_i]
      end
      @attempts += 1
      check_guess
      puts @guess.inspect
      puts @results.inspect
      say_win if @results.all? { |res| res == "O" }
      init_game      
    end
    say_loose
    init_game
  end

  private
    def check_guess
      @guess.each_with_index do |color, index|
        if is_correct?(color, index, @secret)
          @results[index] << "O"
          @guess_count[color] += 1
        end
      end

      @guess.each_with_index do |color, index|
        if is_misplaced?(color, index, @secret)
          if @guess_count[color] < @secret_count[color]
            @results[index] << "M"
            @guess_count[color] += 1
          end
        end
      end

      (0..4).each do |i|
        @results[i] = "X" if @results[i] == ""
      end
    end

    def set_secret
      secret = []
      4.times { |y| secret << COLORS[rand(6)] } 
      return secret
    end

    def fill_secret_count
      @secret.each do |color|
        @secret_count[color] += 1
      end
    end

    def say_win
      puts "you won!!"
      initialize
    end

    def say_loose
      puts "you loose!"
      initialize
    end
end

