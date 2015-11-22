# Joe Eckert
# Foundations of Statistics Homework
# 20151005

library(ggplot2)
library(dplyr)

# Question 1.1
temp <- read.table('01temp.txt', header = TRUE)
summary(temp$Body.Temp)

sd(temp$Body.Temp) #Standard Deviation of Body Temperature
sd(temp$Heart.Rate) #Standard Deviation of Heart Rate
var(temp$Body.Temp) #Variance of Body Temperature
var(temp$Heart.Rate) #Variance of Heart Rate

table(temp) #Contingency Table for Body Temperature and Heart Rate

# Question 1.2

plot(density(temp$Body.Temp), main = "Distribution of Body Temp")
abline(v = mean(temp$Body.Temp), lwd = 2, lty = 2)

plot(density(temp$Heart.Rate), main = "Distribution of Heart Rate")
abline(v = mean(temp$Heart.Rate), lwd = 2, lty = 2)

temp <- group_by(temp, Gender)
tempPlot <- qplot(temp$Heart.Rate, temp$Body.Temp, temp, col = temp$Gender) + theme_bw() + ggtitle("Heart Rate versus Body Temp") + xlab("Heart Rate") + ylab("Body Temp")
tempPlot$labels$colour <- "Gender"
tempPlot

# Question 1.3
t.test(temp$Body.Temp, mu = 98.6, alternative = "two.sided")

### T test shows that the p-value is less than 0.05 therefore we can reject the null hypothesis that the average temperature is 98.6.
### According to the t test, the 95% confidence interval is 98.12 - 98.38 degrees.
### This means that there is a less than 5% chance that the population has a mean temperature of 98.6 given the sample set.

# Question 1.4

male <- filter(temp, Gender == 'Male')
female <- filter(temp, Gender == "Female")
t.test(male$Body.Temp, female$Body.Temp, alternative = "two.sided")

### The two sample t test shows a p value of .02, which is less than .05 and allows us to reject the null hypothesis that there is no difference between the average body temp of males versus females.
### The 95% confidence interval shows that women have on average a lower body temperature than men by about -0.54 and -0.04 degrees.
### This means that on average women have lower body temperatures than men.

# Question 1.5

var.test(female$Heart.Rate, male$Heart.Rate, alternative = "less")

### The p value on the F test is greater than .05 and therefore we cannot reject the null hypothesis that the varience of female heart rates is less than the varience of male heart rates.
### The 95% confidence interval shows that the ratio of heart rate varience between women and men is between 0 and 2.88.
### This means that given the sample set it is unlikely that the population shows a lower variance for female heart rates than for male heart rates.

# Question 2.1

plants <- PlantGrowth
boxplot(plants$weight ~ plants$group, col = c("purple", "blue", "red"), xlab = "Group", ylab = "Weight", main = "Plant Weight by Treatment Group")

# Question 2.2
plants <- group_by(plants, plants$group)
ctrl <- filter(plants, group == "ctrl")
trt1 <- filter(plants, group == "trt1")
trt2 <- filter(plants, group == "trt2")

sd(ctrl$weight)
sd(trt1$weight)
sd(trt2$weight)

bartlett.test(plants$weight, plants$group)

### The bartlett test shows a p value of 0.23, which is not less than 0.05.  Therefore we cannot reject the null hypothesis that the variences of the weights by treatment group are the same.  Therefore there is no significant difference between the weights based on treatment type.

# Question 2.3

summary(aov(plants$weight ~ plants$group))

### Based on the ANOVA test there are significant differences between the average weight of the plants based on the treatment group.  The p value is less than 0.05 which allows us to reject the null hypothesis that there is no difference between these average weights.
### Given the results of the Bartlett test, the ANOVA results are still valid, as the Bartlett test showed no difference in variences of weights by treatment group, not the average.

# Question 3.1

haireye <- HairEyeColor
mosaicplot(haireye, shade = TRUE)

### There are more blond females with blue eyes, and black haired people with brown eyes than expected.
### There are fewer blond people with brown eyes, fewer brown haired females with blue eyes and fewer black haired females with blue eyes than expected.

# Question 3.2

femalebrownblue <- haireye[, 1:2, 2]
mosaicplot(femalebrownblue, shade = TRUE)

### There are more women with blond hair blue eyes and black hair brown eyes than expected.
### There are fewer women with blond hair brown eyes, brown hair blue eyes and black hair blue eyes than expected.

chisqtest <- chisq.test(femalebrownblue)
chisqtest

### The p value of the chi squared test is less than 0.05, therefore we can reject the null hypothesis that there is no relationship between hair and eye color.  Therefore, there is a significant relationship between the color of a woman's hair and her eyes.

# Question 3.3

chisqtest$residuals

### Blond hair blue eyes contributed the most to the statistical deviation (+5.44)
### Blond hair brown eyes contributed the least to the statistical deviation (-5.25)