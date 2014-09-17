

judgeMisses <- function( rounds, judge)
{
  return (
    nrow(
      rounds[rounds$GuesserName == judge & 
             rounds$correct == "no" & 
             (rounds$PlayerType == "bot" | rounds$PlayerType == "epic") ,]))
}
  
