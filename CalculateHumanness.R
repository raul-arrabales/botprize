

CalculateHumanness <- function( rounds, JMeasures )
{
  # First column is the Bot Name
  bots <- GetBots(rounds)
  Measures <- data.frame( bots )
  names(Measures)[1] <- "BotName"
  
  # Next columns are judges -  Unweighted humanness ratio
  judges <- GetJudges(rounds)
  for (judge in judges )
  {
   Measures[judge] <- cbind(Humanness(bots, rounds, judge))
  }
  
  # Get the mean of all judges humanness ratios.
  Measures["Humanness"] <- rowMeans(Measures[2:ncol(Measures)], dims=1)
  
  # Next columns are judges - Weighted humanness ratio
  for (judge in judges)
  {
    Measures[paste("W_",judge, sep="")] <- 
      JMeasures[JMeasures$judges == judge,]$Weight * # Current Judge Weighting factor
      Measures[,judge]  # Unweighted hummannes ratio for this judge
  }
  
  Measures["FPA"] <- rowMeans(Measures[(2+length(judges)):ncol(Measures)], dims=1)
  
  
  return(Measures)
}