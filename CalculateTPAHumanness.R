
CalculateTPAHumanness <- function( tpadata )
{
  # First column is the player Name
  players <- levels(tpadata$PlayerName)
  Measures <- data.frame( players )
  names(Measures)[1] <- "PlayerName"
  Measures["Humanness"] <- rep(0, length(players))
  
  # Build a Humanness column containing all players:
  index <- 1
  
  for (player in players)
  {
    # Total number of guesses for this player
    numVotes <- nrow(tpadata[tpadata$PlayerName == player,]);
    
    # Number of wrong guesses (bot as a human - MISS if player is a bot) for this player
    numMisses <- nrow(tpadata[tpadata$PlayerName == player &
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
 