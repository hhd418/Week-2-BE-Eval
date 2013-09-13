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
    attr_accessor :points, :opponent, :games_won, :sets_won, :match_won

    def initialize
      @points = 0
      @games_won = 0
      @sets_won = 0
      @match_won = 1
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
      return 'forty' if @points == 3
      game_won?
    end

    private

    # Will be called whenever a game has been won and checks to see if a set has been won.
    # Sets can be won 6 to 4 or better or 7 to 6 or 7 to 5.
    def set_won?
      if @games_won == 6 && @opponent.games_won < 5
        @sets_won += 1
        @games_won = 0
        @opponent.games_won = 0
      end
      if @games_won == 7 && @opponent.games_won < 7
        @sets_won += 1
        @games_won = 0
        @opponent.games_won = 0
      end
    end

    # Check to see if a match has been won
    # Players must get to 3 sets to win the match
    def match_won?
      if @sets_won == 3
        @match_won = 1
        @sets_won = 0
        @opponent.sets_won = 0
      end
      if @opponent.sets_won == 3
        @match_won = 1
        @sets_won = 0
        @opponent.sets_won = 0
      end
    end

    # Check to see if a game has been won
    # Players can only win a game if they have gotten to 4 and are up by 2
    # If they get to 3 - 2 or 4 - 3, a point is deducted from each to allow them to get to 4 2
    def game_won?
      if @points == 4
        if @opponent.points < 3
          @games_won += 1
          @points = 0
          @opponent.points = 0
          set_won?
          match_won?
          return 'win'
        elsif @opponent.points == 3
          @points -= 1
          @opponent.points -= 1
          return 'advantage'
        elsif @opponent.points == 4
          @points -= 1
          @opponent.points -= 1
          return 'duece'
        end
      end
    end

  end
end