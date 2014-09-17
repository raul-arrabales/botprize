CalculateTPABotHumanness <- function( tpadata )
{
  # First column is the player Name
  bots <- unique(tpadata[tpadata$PlayerType == "Bot", "PlayerName"])
  Measures <- data.frame( bots )
  names(Measures)[1] <- "BotName"
  Measures["Humanness"] <- rep(0, length(bots))
  
  # Build a Humanness column containing all players:
  index <- 1
  
  for (bot in bots)
  {
    # Total number of guesses for this player
    numVotes <- nrow(tpadata[tpadata$PlayerName == bot,]);
    
    # Number of wrong guesses (bot as a human - MISS if player is a bot) for this player
    numMisses <- nrow(tpadata[tpadata$PlayerName == bot &
                                # tpadata[tpadata$PlayerType == "bot" &  # this condition only for bots
                                tpadata$Guess == "Human" 
                              ,])
    
    # print(c(player, numVotes, " - ", numMisses, numMisses/numVotes))
    Measures[index,"Humanness"] <- numMisses/numVotes
    
    # In case of no votes 0/0
    if (!is.finite(Measures[index,"Humanness"]))
    {
      Measures[index,"Humanness"] <- 0
    }
    index <- index + 1
    
  }
  
  return(Measures)
}
