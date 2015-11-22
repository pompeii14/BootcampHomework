# Data Visualization Homework
# Joe Eckert

# Question 1 - Dplyr Review
library(dplyr)
CL <- read.csv("Champions.csv")
CL <- tbl_df(CL)

# Question 1.1
# Games where the home team wins
CL_homeWin <- filter(CL, HomeGoal > AwayGoal)

# Games where the home team is Barcelona or Real Madrid
CL_FCB_RFC_home <- filter(CL, HomeTeam == "Barcelona" | HomeTeam == "Real Madrid")

# Question 1.2
# Fields related to the home team
CL_homeStats <- select(CL, contains("Home", ignore.case = TRUE))

# Create a table with the six specified columns
CL_custStats <- select(CL, HomeTeam, AwayTeam, HomeGoal, AwayGoal, HomeCorner, AwayCorner)

# Question 1.3
# Sort the table by the number of home goals
CL_custStatsSorted <- arrange(CL_custStats, desc(HomeGoal))

# Question 1.4 - average summary statistics by home team
CL_groupHome <- group_by(CL, HomeTeam)
CL_homeSummary <- summarise(CL_groupHome, avgGoal = mean(HomeGoal), avgPoss = mean(HomePossession), avgYellow = mean(HomeYellow))

# Question 1.5
CL_scoreFreq <- transmute(CL, HomeTeam, AwayTeam, score = paste(HomeGoal, AwayGoal, sep = ":"))
CL_scoreFreq <- CL_scoreFreq %>% count(score)
CL_scoreFreq <- arrange(CL_scoreFreq, desc(n))
# 0:0 and 1:0 are both tied with a frequency of 12


# Question 2
CL2 <- read.csv("Champions.csv")

# Question 2.1
# Games where the home team wins
CL_homeWin_2 <- CL2[CL2$HomeGoal > CL2$AwayGoal, ]

# Games where the home team is Barcelona or Real Madrid
CL_FCB_RFC_home2 <- CL2[CL$HomeTeam == "Barcelona" | CL2$HomeTeam == "Real Madrid", ]

# Question 2.2
# Fields related to the home team
CL_homeStats2 <- CL2[ , grepl("Home", names(CL2))]

# Create a table with the six specified columns
CL_custStats2 <- CL2[ , c("HomeTeam", "AwayTeam", "HomeGoal", "AwayGoal", "HomeCorner", "AwayCorner")]

# Question 2.3
# Sort the table by the number of home goals
CL_custStatsSorted2 <- CL_custStats2[order(-CL_custStats2$HomeGoal), ]

# Question 2.4 - average summary statistics by home team
library(reshape2)
CL_homeSummary2 <- CL2[ , c("HomeTeam", "HomeGoal", "HomePossession", "HomeYellow")]
CL_homeSummary2 <- melt(data = CL_homeSummary2, id.vars = 'HomeTeam', measure.vars = c("HomeGoal", "HomePossession", "HomeYellow"))
CL_homeSummary2 <- dcast(data = CL_homeSummary2, HomeTeam ~ variable, value.var = 'value', fun = mean)


# Question 2.5
CL_scoreFreq2 <- CL2[ , c("HomeTeam", "AwayTeam", "HomeGoal", "AwayGoal")]
CL_scoreFreq2$score <- paste(CL_scoreFreq2$HomeGoal, CL_scoreFreq2$AwayGoal, sep=":")
CL_scoreFreq2 <- dcast(data = CL_scoreFreq2, score ~ ., value.var='score', fun = length)
names(CL_scoreFreq2)[2] <- "scoreCount"
CL_scoreFreq2 <- CL_scoreFreq2[order(-CL_scoreFreq2$scoreCount), ]
# 0:0 and 1:0 are both tied with a frequency of 12


# Question 3
# Question 3.1
plot(dist ~ speed, cars)

# Question 3.2
plot(dist ~ speed, cars, main = "Speed vs. Stopping Distance", xlab = "Speed (mph)", ylab = "Stopping Distance (ft)")

# Question 3.3
plot(dist ~ speed, cars, main = "Speed vs. Stopping Distance", xlab = "Speed (mph)", ylab = "Stopping Distance (ft)", pch = 17, col = "red")

# Question 3.4
library(ggplot2)
myPlot <- qplot(speed, dist, data = cars)
myPlot <- myPlot + ggtitle("Speed vs. Stopping Distance")
myPlot$labels$x = "Speed (mph)"
myPlot$labels$y = "Stopping Distance (ft)"
myPlot <- myPlot + geom_point(colour = "red", pch = 17)
myPlot

# Question 4
house = function(x, y, ...){
  lines( c(x-1, x+1, x+1, x-1, x-1),
         c(y-1, y-1, y+1, y+1, y-1), ...)
  lines (c(x-1, x, x+1), c(y+1, y+2, y+1), ...)
  lines( c(x - 0.3, x+0.3, x+0.3, x-0.3, x-0.3),
         c(y-1, y-1, y+0.4, y+0.4, y-1), ...)
}

# Question 4.1
plot.new()
plot.window(c(0,10), c(0,10))

# Question 4.2
house(1,1)
house(4,2)
house(7,6)

# Question 4.3
house(7,6, col = "violet", lwd = 2)
house(5,6, col = "slateblue", lty = 2, lwd = 3)

# Question 4.4
box(which = "plot")


# Question 5
# Question 5.1
curve(dbeta(x, 2, 6), from=0, to=1)
curve(dbeta(x, 4, 4), from=0, to=1, add=TRUE)
curve(dbeta(x, 6, 2), from=0, to=1, add=TRUE)

# Question 5.2
title(expression(f(y)==frac(1,B(a,b))*y^{a-1}*(1-y)^{b-1}))

# Question 5.3
text(0.2, 2.5, "(2,6)")
text(0.5, 2, "(4,4)")
text(0.8, 2.5, "(6,2)")

# Question 5.4
curve(dbeta(x, 2, 6), from=0, to=1, col="red", lty=1)
curve(dbeta(x, 4, 4), from=0, to=1, add=TRUE, col="blue", lty=2)
curve(dbeta(x, 6, 2), from=0, to=1, add=TRUE, col="green", lty=3)
title(expression(f(y)==frac(1,B(a,b))*y^{a-1}*(1-y)^{b-1}))

# Question 5.5
legend(0.2, 1, c("(2,6)","(4,4)","(6,2)"), fill=c("red", "blue", "green"))

# Question 6

# Question 6.1
myFaithful <- faithful
myFaithful$length <- ifelse(myFaithful$eruptions < 3.2, "short", "long")

# Question 6.2
library(lattice)
bwplot(waiting ~ length, data=myFaithful)

# Question 6.3
densityplot(~ waiting, data=myFaithful, groups=length)

# Question 6.4
# the waiting time for short eruptions is about 55 seconds, and about 80 seconds for long eruptions
# given that information we can generally predict whether or not the eruption will be long or short given the amount of time we waited

# Question 6.5
qplot(length, waiting, data = myFaithful, geom="boxplot")

# Question 6.6
qplot(waiting, data=myFaithful, geom="density", color=length)


# Question 7
load("Knicks.rda")
knicks <- data

# Question 7.1
knicks <- tbl_df(knicks)
knicks$season <- as.character(knicks$season)
knicksSummary <- summarise(group_by(knicks, season), gameCount = n())
knicksSummary <- left_join(knicksSummary, summarise(group_by(filter(knicks, win == 'W'), season), wins = n()), by = "season")
knicksSummary$winRatio <- (knicksSummary$wins / knicksSummary$gameCount)
qplot(knicksSummary$season, knicksSummary$winRatio, data = knicksSummary, stat = "identity", geom = "bar") + 
  ggtitle("Knicks Win Ratio Over Time") + xlab("Season") + 
  ylab("Win Ratio")

# Question 7.2
knicksHA <- mutate(knicks, played = ifelse(knicks$visiting == 1, "Away", "Home"))
knicksHASum <- summarise(group_by(knicksHA, season, played), gameCount = n())
knicksHASum <- filter(knicksHA, win == 'W') %>%
  group_by(., season, played) %>%
    summarise(., wins = n()) %>%
      left_join(knicksHASum, ., by = c("season", "played"))
knicksHASum$winRatio <- (knicksHASum$wins / knicksHASum$gameCount)
knicksHASum$played <- as.factor(knicksHASum$played)
qplot(season, winRatio, data = knicksHASum, stat = "identity", geom = "bar", cut = played)

ggplot(knicksHASum, aes(x=season, y=winRatio, fill=played)) + geom_bar(stat="identity", position="dodge") +
  xlab("Season") + ylab("Win Ratio") + ggtitle("Knicks Win Ratio by Season")

# Question 7.3
ggplot(data=knicks, aes(x=points)) + geom_histogram(binwidth=5) + facet_wrap( ~ season) +
  xlab("Points") + ylab("Count") + ggtitle("Point Distribution by Season")

# Question 7.4
knicks_oppAnly <- mutate(knicks, win=ifelse(win=='W', 1, 0), pntdiff = (points - opp))
knicks_oppAnlySum <- group_by(knicks_oppAnly, opponent)
knicks_oppAnlySum <- summarise(knicks_oppAnlySum, winRatio = mean(win), avgPntDiff = mean(pntdiff))

ggplot(data=knicks_oppAnlySum, aes(x=winRatio, y=avgPntDiff)) + geom_point() +
  xlab('Win Ratio') + ylab('Average Point Differential') + ggtitle("Win Ratio vs Point Differential by Opponent")

# Question 8
ggplot(data = iris, aes(x = Sepal.Width, y=Sepal.Length, color=Species)) + theme_bw() +
  stat_density2d(geom='polygon', aes(fill=Species, alpha=..level..), size = 0) +
  geom_rug(position = 'jitter')
