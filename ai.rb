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

  attr_reader :secret, :results, :attempts
  attr_accessor :guess

  def initialize
    @secret_count = Hash.new(0)
    @secret = set_secret
    @attempts = 10
    @guess = []
    init_game
    fill_secret_count
  end

  def reduce
    @attempts -= 1
  end

  def check_guess
    init_game
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

  private

    def init_game
      @guess_count = Hash.new(0)
      @results = ["", "", "", ""]
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
end

