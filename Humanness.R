
# Returns a vector of humanness ratios for each bot, 
# based in the votes from the specified judge

Humanness <- function( bots, rounds, judge )
{
  Hvector <- vector()
  index <- 1
  
  for (bot in bots)
  {
    votes <- rounds[rounds$PlayerName == bot & rounds$GuesserName == judge, ]
    misses <- rounds[rounds$PlayerName == bot & rounds$GuesserName == judge & rounds$correct == "no", ]          
    Hvector[index] <- nrow(misses) / nrow(votes)
    
    # In case of no votes 0/0
    if (!is.finite(Hvector[index]))
    {
      Hvector[index] <- 0
    }
    index <- index + 1
  }
  
      
  return(Hvector)
}