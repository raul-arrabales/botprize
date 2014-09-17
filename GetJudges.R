
GetJudges <- function(rounds)
{
  judgesRows <- rounds[rounds$GuesserType == "human",]
  judgesNames <- judgesRows[,c('GuesserName')]
  
  return (unique(judgesNames))
}