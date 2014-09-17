
# Calculates Fleiss kappa statistic as a measure of inter-rater reliability
# See http://en.wikipedia.org/wiki/Fleiss%27_kappa 

Fleisskappa <- function( HoB )
{
  nplayers <- nrow(HoB) # Number of players, one per row (N)
  nraters <- ncol(HoB)  # Number of judges (n)
  
  ratersAgreedBot <- vector()  # Number of judges that agree a player is a Bot
 # ratersAgreedHuman <- vector()  # Number of judges that agree a player is a Human
  Pi <- vector()  # One Pi per player
  
  # Calculate number of judges that agree a player is a Bot
  for (p in 1:nplayers)
  {
    nagreed <- 0
    for (judge in 1:nraters)
    {
      if (HoB[p,judge] == "Bot")
      {
        nagreed <- nagreed + 1
      }
    }
    ratersAgreedBot[p] <- nagreed
  }
  
  # Calculate number of judges that agree a player is a Human
#   for (p in 1:nplayers)
#   {
#     nagreed <- 0
#     for (judge in 1:nraters)
#     {
#       if (HoB[p,judge] == "Human")
#       {
#         nagreed <- nagreed + 1
#       }
#     }
#     ratersAgreedHuman[p] <- nagreed
#   }
  
  # Calculate Pj
  sumBotAgrees <- 0
 # sumHumanAgrees <- 0
  for (i in 1:length(ratersAgreedBot))
  {
    sumBotAgrees <- sumBotAgrees + ratersAgreedBot[i]
  #  sumHumanAgrees <- sumHumanAgrees + ratersAgreedHuman[i]
  }
  
  Pjbot <- sumBotAgrees / (nraters*nplayers)
 # Pjhuman <- sumHumanAgrees / (sumBotAgrees+sumHumanAgrees)
  
  
  # Calculate Pi values
  for (p in 1:nplayers)
  {  
     Pi[p] <- (1/(nraters*(nraters-1))) 
     Pi[p] <-Pi[p] *
              ((ratersAgreedBot[p]*ratersAgreedBot[p]) - nraters) 
  }

  sumPi <- 0
  
  for(i in 1:length(Pi))
  {
    sumPi <- sumPi + Pi[i]
  }
   
  P <- sumPi / nplayers
   
  Pe <- (Pjbot*Pjbot)# + (Pjhuman*Pjhuman) # There is only two categories (bot and human)
  
  K <- (P - Pe) / (1 - Pe)
  
  print(Pjbot)
  #print(Pjhuman)
  print(Pi)
  print(sumPi)
  print(P)
  print(Pe)
  print(K)

  return(K)
}
