

judgeHits <- function( rounds, judge )
{
  return (nrow(rounds[rounds$correct=="yes" & rounds$GuesserName == judge,]))
}