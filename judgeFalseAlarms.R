

judgeFalseAlarms <- function( rounds, judge )
{
  return (
    nrow(
      rounds[rounds$GuesserName == judge & 
               rounds$correct == "no" & 
               rounds$PlayerType == "human",]))
}
