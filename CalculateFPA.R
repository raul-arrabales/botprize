
# Calculates FPA for all bots using judge measures (JRR) and Bot Measures (Humanness)

CalculateFPA <- function( JMeasures, BMeasures )
{
  measures <- data.frame(BMeasures$BotName, BMeasures$Humanness)
  
  for (judge in JMeasures$judges)
  {
    print(judge)
    measures[judge] 
  }
  
  return(measures)
}