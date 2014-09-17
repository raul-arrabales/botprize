
GetBots <- function(rounds)
{
  botNames <- rounds[rounds$PlayerType == "bot", "PlayerName"]
  
  return (unique(botNames))
}