
# FPA - First Person Assessment Score

FPA <- function( JRR )
{
  print(JRR)
  scores <- data.frame()
  
  scores["FPA"] <- JRR 
  
  print(scores$FPA)
  
  return(scores$FPA)
}