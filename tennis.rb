module Tennis
  class Game
    attr_accessor :player1, :player2

    def initialize
      @player1 = Player.new
      @player2 = Player.new

      @player1.opponent = @player2
      @player2.opponent = @player1
    end

    # The wins_ball method takes an argument of 1 or 2 to reference the player that won the point.
    # If an invalid player number is entered the score will not be recorded.
    # 
    # Example
    #
    #    game.wins_ball(2)
    #    the record_won_ball! method will record and add a point to @player2
    def wins_ball(x)
      if x == 1
        @player1.record_won_ball!
      elsif x == 2
        @player2.record_won_ball!
      else
        puts 'No scored was recored. Please enter a vaild player number.'
        return false
      end
    end
  end

  class Player
    attr_accessor :points, :opponent

    def initialize
      @points = 0
    end

    # Increments the score by 1.
    #
    # Returns the integer new score.
    def record_won_ball!
      @points += 1
    end

    # Returns the String score for the player.
    def score
      return 'love' if @points == 0
      return 'fifteen' if @points == 1
      return 'thirty' if @points == 2
      return 'duece' if @points == 3 && @opponent.points == 3
      return 'advantage' if @points == 4 && @opponent.points == 3
      return 'forty' if @points == 3
    end
  end
end