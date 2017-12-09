COLORS = ["blue", "red", "green", "yellow", "orange", "pink"]

class GameIA
  include GameHelpers

  def initialize
    init_game
  end

  def init_game
    @attempts = 0
    @secret = set_secret
    @guess = []
    @results = Hash.new
  end

  def ingame

  end

  private
    def set_secret
      secret = []
      4.times { |y| secret << COLORS[rand(6)] } 
      return secret
    end
end

module GameHelpers
  def is_correct?

  end

  def is_misplaced?

  end

  def is_wrong?
    return true if (!is_correct && !is_misplaced)
    return false
  end
end
