
CalculateJR <- function( rounds, judges)
{
   JRmeasures <- numeric()
     
   for (i in judges)
   {
      JRmeasures <- c(JRmeasures, judgeReliability(rounds, i))  
   }

   JR.data <- data.frame(judges, JRmeasures)
   
   return (JR.data)
  
}