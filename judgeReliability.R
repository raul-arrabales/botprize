

judgeReliability <- function( rounds, judge )
{
  reliability <- numeric()
  hits <- judgeHits(rounds, judge)
  failures <- judgeMisses(rounds, judge) + judgeFalseAlarms(rounds, judge)
  
  reliability <- (hits - failures) / (hits + failures)
  
  # Control 0/0 NaN in case there are no votes from this judge, reliability is zero.
  if (!is.finite(reliability))
  {
    reliability <- 0
  }
  
  return(reliability) 
}