class TennisScorer

 attr_accessor :score
  def initialize
    
    @receiverScore=0
    @serverScore=0
    @score="0-0"
  end


  def ScoreServer
      if @serverScore == 0 || @serverScore == 15
         @serverScore = @serverScore+15
         @score="#{@serverScore}-#{@receiverScore}"
         return @score
      end

    if @serverScore ==30
      if @receiverScore==40
        @score="deuce"
      else
        @serverScore=40
        @score="#{@serverScore}-#{@receiverScore}"
      end
        return @score
    end

     if @score=="deuce"
      @serverScore="advantage Server"
      @score="advantage Server"
    end
      return @score
    if @receiverScore=="advantage receiver"
        @score="deuce"
    end
      return @score
    if @score != "advantage receiver" || @score!="deuce"
      @score="Server win"
    end
      return @score

    @score
  end


  def ScoreReceiver

    if @receiverScore == 0 || @receiverScore == 15
         @receiverScore = @receiverScore+15
         @score="#{@serverScore}-#{@receiverScore}"

      end
      return @score
    if @receiverScore ==30
      if @serverScore==40
        @score="deuce"
      else
        @receiverScore=40
        @score="#{@serverScore}-#{@receiverScore}"
      end
      return @score
    end

    if @score=="deuce"
      @receiverScore="advantage receiver"
      @score="advantage receiver"
    end
    return @score
    if @serverScore=="advantage Server"
        @score="deuce"
    end
    return @score
    if @score != "advantage Server" || @score!="deuce"
      @score="receiver win"
    end


    return @score
    
  end

end