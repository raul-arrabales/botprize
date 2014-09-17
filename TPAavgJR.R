

# Calculates Third-Person Assessment Average Judge Reliability
TPAavgJR <- function( guesses )
{
  
  # Total number of guesses
  N <- nrow(guesses)
  
  CorrectGuesses <- nrow(guesses[(guesses$Guess == "Machine" & guesses$PlayerType == "Bot") |  
                                 (guesses$Guess == "Human" & guesses$PlayerType == "Human"),])
  
  WrongGuesses <- N - CorrectGuesses

  
  return ( (CorrectGuesses - WrongGuesses) / N )
  
}