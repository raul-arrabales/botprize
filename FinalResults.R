
# ---------------------------------------------
# BotPrize 2014 Data Analytics - Raúl Arrabales
#
# Aug. 2014. raul@conscious-robots.com 
# ---------------------------------------------

print("Calculating BotPrize 2014 results...")

# ------------
# LOADING DATA
# ------------

# fpadata - Data frame with First-Person Assessment Data
print("Loading FPA data.")
fpadata <- readRDS("FPAdata.rds")

# tpadata - Dara frame with Third-Person Assessment Data
print("Loading TPA data.")
tpadata <- readRDS("TPAdata.rds")


# -----------------------
# FIRST-PERSON ASSESSMENT
# -----------------------

# Get First-Person Assessment Judges Names
FPAjudges <- GetJudges(fpadata)
print("FPA human judges are: ")
print(FPAjudges)
writeLines(" ")

# Get First-Person Assessment Bots Names
FPAbots <- GetBots(fpadata)
print("FPA bots are: ")
print(FPAbots)
writeLines(" ")


# JUDGE RELIABILITY - JRmeasures

# Judge Realiability Measures - Calculate FPA judges reliability
print("Calculating FPA Judge Reliability Measures")
JRmeasures <- CalculateJR(fpadata, FPAjudges)
print(JRmeasures)
writeLines(" ")

# Bots Judging Reliability Measures - Calculate FPA bots judging skills
print("Calculating FPA Bots Judging Reliability")
JRmeasuresBots <- CalculateJR(fpadata, FPAbots) 
print(JRmeasuresBots)
writeLines(" ")

# Average Judge Reliability
AvgJR <- sum(JRmeasures$JRmeasures) / nrow(JRmeasures)
print("Average Judges Judging Reliability:")
print(AvgJR)

# Average Judge Reliability
AvgJRbots <- sum(JRmeasuresBots$JRmeasures) / nrow(JRmeasuresBots)
print("Average Bots Judging Reliability:")
print(AvgJRbots)
writeLines(" ")

# Based on this JRR (the relative reliability of each judge), 
# we calculate the weighting factor for each judge: 
  
JRmeasures["JRR"] <- JRmeasures$JRmeasures / AvgJR
JRmeasures["Weight"] <- JRmeasures$JRR / nrow(JRmeasures)

# Judge Reliability of all FPA players
JRmeasuresAll <- merge(JRmeasures[,c("judges", "JRmeasures")],JRmeasuresBots[,c("judges", "JRmeasures")], all.x=TRUE, all.y=TRUE)
# Ordered by reliability
JRmeasuresAll <- JRmeasuresAll[order(JRmeasuresAll$JRmeasures, decreasing=TRUE),]

print("All players judging reliability:")
print(JRmeasuresAll)
writeLines(" ")


# Bar Plots of Judge Reliability measures
JRmeasures <- JRmeasures[order(JRmeasures$JRmeasures, decreasing=TRUE),]
barplot(JRmeasures$JRmeasures, main="Human Judges Reliability", 
        names.arg=JRmeasures$judges)

JRmeasuresBots <- JRmeasuresBots[order(JRmeasuresBots$JRmeasures, decreasing=TRUE),]
barplot(JRmeasuresBots$JRmeasures, main="Bots Judging Reliability", 
        names.arg=JRmeasuresBots$judges, cex.names=0.8, las=2)

barplot(JRmeasuresAll$JRmeasures, main="Human Judges and Bots Judging Reliability", 
        names.arg=JRmeasuresAll$judges, cex.names=0.8, las=2)

barplot(c(AvgJR, AvgJRbots), main="Human Judges and Bots Judging Average Reliability", 
         col = c("blue", "yellow"), names.arg=c("Humans","Bots"))

barplot(JRmeasures$Weight, main="Judge Weighting Factor", 
        names.arg=JRmeasures$judges)

barplot(data.matrix(JRmeasures[,2:4]), 
        main="Judge Reliability Measures", 
        col = c("darkblue", "red", "green", "brown"), 
        legend = JRmeasures[,1], beside=TRUE) 


# GETTING THE HUMANNESS RATIO

print("Calculating Humanness and FPA ratios for bots:")
BotMeasures <- CalculateHumanness(fpadata, JRmeasures)

# Ordered by Humanness
BotMeasures <- BotMeasures[order(BotMeasures$Humanness, decreasing=TRUE),]

print(BotMeasures[,c("BotName", "Humanness", "FPA")])
writeLines(" ")

# Bar Plots of Bot Hummanness measures
barplot(BotMeasures$Humanness, 
        main="Bots Unweighted Humanness Ratio", 
        names.arg=BotMeasures$BotName, 
        cex.names=0.8, las=2)

barplot(BotMeasures$FPA, 
        main="Bots FPA Scores", 
        names.arg=BotMeasures$BotName, 
        cex.names=0.8, las=2)

barplot(t(BotMeasures[,c("Humanness", "FPA")]), 
        main="Bots Humanness & FPA Scores", 
        names.arg=BotMeasures$BotName, 
        cex.names=0.8, las=2, 
        legend=c("Humanness", "FPA"), beside=TRUE)


# Calculate inter-rater reliability

library(irr) # Load inter-rater reliability library

FPrates <- BotMeasures[,2:5] # Humanness proportions for each player by rater

print("Humanness proportions for each player by rater")
print(BotMeasures[,1:5])
writeLines(" ")

CategoricalBotMeasures <- HumanOrBot(FPrates)
print("Humanness categorical classsification for each player by rater")
print(CategoricalBotMeasures)
writeLines(" ")

# Calculate the Flesiss Kappa
print("Inter-rate Reliability - Fleiss Kappa:")
print(kappam.fleiss(CategoricalBotMeasures))
writeLines(" ")

# Calculate humanness ratio also for human judges:
print("Calculating Humanness and FPA ratios for judges:")
JudgeMeasures <- CalculateJudgeHumanness(fpadata, JRmeasures)

# Ordered by Humanness
JudgeMeasures <- JudgeMeasures[order(JudgeMeasures$Humanness, decreasing=TRUE),]

print(JudgeMeasures[c("BotName", "Humanness", "FPA")])
writeLines(" ")

# Bar Plots of Human Judges Hummanness measures
barplot(t(JudgeMeasures[,c("Humanness", "FPA")]), 
        main="Human Judges Humanness & FPA Scores", 
        names.arg=JudgeMeasures$BotName, 
        cex.names=0.8, las=2, 
        legend=c("Humanness", "FPA"), beside=TRUE)

# All players together:
allMeasures <- rbind(BotMeasures, JudgeMeasures)
allMeasures <- allMeasures[order(allMeasures$Humanness, decreasing=TRUE),]
print("Combined Humanness Measures:")
print(allMeasures[c("BotName", "Humanness", "FPA")])
writeLines(" ")

# Bar Plots of all players Hummanness measures
barplot(t(allMeasures[,c("Humanness", "FPA")]), 
        main="Players Humanness & FPA Scores", 
        names.arg=allMeasures$BotName, 
        cex.names=0.8, las=2, 
        legend=c("Humanness", "FPA"), beside=TRUE)

barplot(t(allMeasures[,c("Humanness")]), 
        main="Players Humanness Scores", 
        names.arg=allMeasures$BotName, 
        cex.names=0.8, las=2)

allMeasures <- allMeasures[order(allMeasures$FPA, decreasing=TRUE),]

barplot(allMeasures[,c("FPA")], 
        main="Players FPA Scores", 
        names.arg=allMeasures$BotName, 
        cex.names=0.8, las=2)

# -----------------------
# THIRD-PERSON ASSESSMENT
# -----------------------

print("Calculating TPA results...")
writeLines(" ")

# Calculate Judges reliability in TPA tasks
print("TPA judges average reliability:")
AvgJRtpa <- TPAavgJR(tpadata)
print(AvgJRtpa)
writeLines(" ")

print("TPA H Results:")
TPAresults <- CalculateTPAHumanness(tpadata)
TPAresults <- TPAresults[order(TPAresults$Humanness, decreasing=TRUE),]
print(TPAresults)
writeLines(" ")

# Looking only at bots
BotTPAresults <- CalculateTPABotHumanness(TPAdata) 
BotTPAresults <- BotTPAresults[order(BotTPAresults$Humanness, decreasing=TRUE),]
print("TPA Humanness for bots:")
print(BotTPAresults)
writeLines(" ")


# Bar Plots of all players TPA humanness measures

barplot(c(AvgJR, AvgJRbots, AvgJRtpa), main="FPA Judges, FPA Bots and TPA Judges Average Reliability", 
        col = c("blue", "red", "yellow"), names.arg=c("FPA H", "FPA B", "TPA H"))

barplot(TPAresults$Humanness, 
        main="Players TPA Humanness Ratio", 
        names.arg=TPAresults$PlayerName, 
        cex.names=0.8, las=2)

barplot(BotTPAresults$Humanness, 
        main="Bots TPA Humanness Ratio", 
        names.arg=BotTPAresults$BotName, 
        cex.names=0.8, las=2)


# -----------------------------------
# FINAL RESULTS - Combining FPA & TPA
# -----------------------------------

# Adding FPA measures
FinalResults <- allMeasures

# Adding last column with final Humanness = FPA*FPWF + TPA*TPWF;
FPWF <- 0.5
TPWF <- 0.5

# Adding TPA and final score measures
FinalResults["TPA"] <- rep(0, length(FinalResults$BotName))
FinalResults["H"] <- rep(0, length(FinalResults$BotName))

for (player in FinalResults$BotName )
{
   # print(c("player:",player,TPAresults[TPAresults$PlayerName == player, "Humanness"], nrow(FinalResults[FinalResults$BotName == player,] )) )
   
   if ( nrow(FinalResults[FinalResults$BotName == player,] ) == 1 )
   {
     FinalResults[FinalResults$BotName == player,"TPA"] <- 
                        TPAresults[TPAresults$PlayerName == player, "Humanness"]
   
     FinalResults[FinalResults$BotName == player,"H"] <- 
       FPWF * FinalResults[FinalResults$BotName == player,"TPA"] +
       TPWF * FinalResults[FinalResults$BotName == player,"FPA"]     
   }
   
}

FinalResults <- FinalResults[order(FinalResults$H, decreasing=TRUE),]

print("Final Results:")
print(FinalResults[c("BotName", "Humanness", "FPA", "TPA", "H")])
writeLines(" ")
print(FinalResults[c("BotName", "FPA", "TPA", "H")])
writeLines(" ")

# Bar Plots of all players H measures
barplot(t(FinalResults[,c("FPA", "TPA", "H")]), 
        main="Players FPA, TPA & H Scores", 
        names.arg=FinalResults$BotName, 
        cex.names=0.8, las=2, 
        legend=c("FPA", "TPA", "H"), beside=TRUE)
