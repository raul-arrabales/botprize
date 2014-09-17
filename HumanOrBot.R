
# Takes a humanness ratios dataframe and converts it into categorical human or bot

HumanOrBot <- function( hratios )
{
  HoB <- hratios
  
  for (i in 1:nrow(hratios))
    for (j in 1:ncol(hratios))
      if ( hratios[i,j] >= 0.5)
        HoB[i,j] <- "Human"
      else
        HoB[i,j] <- "Bot"
    
  return(HoB)
}