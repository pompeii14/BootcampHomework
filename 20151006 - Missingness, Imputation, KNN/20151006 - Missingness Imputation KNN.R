# Joe Eckert
# Missingness, Imputation, KNN Homework
# 20151006

library(PASWR)
library(VIM)
library(mice)
library(Hmisc)
library(kknn)

# Question 1.1

titanic <- titanic3
aggr(titanic)
md.pattern(titanic)

## There are three variables with missing data
##    age - 263 missing values (~20%)
##    fare - 1 missing value (<1%)
##    body - 1188 missing values (~90%)

# Question 1.2

length(complete.cases(titanic)[complete.cases(titanic)==TRUE])
length(complete.cases(titanic)[complete.cases(titanic)==TRUE]) / nrow(titanic)

## There are 119 complete observations, which is 9.09% of the total observations

# Question 1.3

md.pattern(titanic)

## There are 1452 missing values in this dataset

# Question 1.4

md.pattern(titanic)

## There are 119 complete observations
## There is 1 observation missing age
## There is 1 observation missing fare
## There are 926 observations missing body
## There are 262 observations missing age and body

# Question 1.5

## age - missing at random, there are 263 missing values for this variable, it appears that age is more likely to be missing in the cases where the passenger did not survive.  There are 73 survivors missing an age and 190 deaths missing an age.
## fare - missing completely at random, there is only one value missing for this variable, likely due to human error
## body - missing not at random, there are 1188 missing values for this variable, the body identification number is only present if the passenger died, in 809 observations where the passenger did not survive there are 688 observations missing a body identification number

# Question 1.6

# plot distribution of age before imputation
qplot(titanic$age)

# impute the age using mean value imputation
titanic.imp <- titanic
titanic.imp$age <- impute(titanic$age, mean)

# plot distribution of age after imputation
qplot(titanic.imp$age)

## Given the high number of observations missing the age value (263) these will be assigned the average age, greatly reducing the standard deviation and varience of the data

# Question 1.7

# plot distribution of age before imputation
qplot(titanic$age)

# impute the age using random imputation
titanic.imp <- titanic
set.seed(0)
titanic.imp$age <- impute(titanic$age, "random")

# plot distribution of age after imputation
qplot(titanic.imp$age)

summary(titanic$age)
sd(titanic$age, na.rm = TRUE)
summary(titanic.imp$age)
sd(titanic.imp$age)

## the issue with random imputation is that it can introduce bias by amplifying outlier observations
## when looking at the mean before imputation (29.88) and after (30.07) there doesnt appear to be a large impact to the mean


# Question 2.1

titanic[is.na(titanic$fare), ]
titanic.imp <- titanic
set.seed(0)
titanic.imp$fare <- impute(titanic$fare, "random")
titanic.imp[1226, ]

## The fare that was imputed was 69.55

# Question 2.2

titanic.imp <- titanic
set.seed(0)
titanic.imp$age <- impute(titanic.imp$age, "random")
set.seed(0)
titanic.imp$fare <- impute(titanic.imp$fare, "random")

qplot(titanic.imp$fare, titanic.imp$age, col = titanic.imp$pclass)

## the fare for second and third class is pretty low regardless of age, there is a wider disparity of the fare for 1st class passengers, however there doesnt seem to be a correlation to age and fare for 1st class.

# Question 2.3

titanic.imp[nrow(titanic.imp) + 1, 'age'] <- 50
titanic.imp[nrow(titanic.imp), 'fare'] <- 400
titanic.imp[nrow(titanic.imp) + 1, 'age'] <- 10
titanic.imp[nrow(titanic.imp), 'fare'] <- 100

# Question 2.4

## I would assume that both passengers that were added would be 1st class, looking at the plot from question 2.2 there are no passengers from the 2nd or 3rd class with a fare above $100

# Question 2.5

titanic.imp = kNN(titanic.imp, "pclass", k = 1)

titanic.imp[1310:1311, ]

## the first passenger (50 y/o) was mapped to 1st class and the second was mapped to 3rd class

# Question 2.6

# rebuild the imputed dataset before knn
titanic.imp <- titanic
set.seed(0)
titanic.imp$age <- impute(titanic.imp$age, "random")
set.seed(0)
titanic.imp$fare <- impute(titanic.imp$fare, "random")
titanic.imp[nrow(titanic.imp) + 1, 'age'] <- 50
titanic.imp[nrow(titanic.imp), 'fare'] <- 400
titanic.imp[nrow(titanic.imp) + 1, 'age'] <- 10
titanic.imp[nrow(titanic.imp), 'fare'] <- 100

# impute pclass using sqrt(n) for knn

sqrt(nrow(titanic.imp)) # will use 36 for knn

titanic.imp = kNN(titanic.imp, "pclass", k = 36)
titanic.imp[1310:1311, ]

## by using 36 nearest neighbors the classes assigned did not change from the imputation using 1 nearest neighbor, I believe they did not change because of the relationship between fare/age.  I believe that the 10 y/o passenger is still being incorrectly assigned to 3rd class because of the low number younger passengers in 1st class.


# Question 3.1

titanicq3 <- titanic3[, c("pclass", "survived", "sex", "age", "sibsp", "parch", "fare")]
set.seed(0)
titanicq3$fare <- impute(titanicq3$fare, "random")

# Question 3.2

# complete cases
titanicq3.comp <- titanicq3[complete.cases(titanicq3)==TRUE, ]
# observations missing age
titanicq3.agemis <- titanicq3[is.na(titanicq3$age), ]
titanicq3.agemis <- titanicq3.agemis[, -4]

# Question 3.3

# run knn
titanic3.agemis.man <- kknn(age ~ ., titanicq3.comp, titanicq3.agemis, k=1, distance=1)
titanic3.agemis.euc <- kknn(age ~ ., titanicq3.comp, titanicq3.agemis, k=1, distance=2)
titanic3.agemis.p10 <- kknn(age ~ ., titanicq3.comp, titanicq3.agemis, k=1, distance=10)

# convert results of fitted values to dataframe (for ggplot) and rename column to fit
titanic3.agemis.man <- data.frame(titanic3.agemis.man$fitted.values)
names(titanic3.agemis.man)[1] <- "fit"

titanic3.agemis.euc <- data.frame(titanic3.agemis.euc$fitted.values)
names(titanic3.agemis.euc)[1] <- "fit"

titanic3.agemis.p10 <- data.frame(titanic3.agemis.p10$fitted.values)
names(titanic3.agemis.p10)[1] <- "fit"

# Question 3.4

plot <- ggplot(titanicq3.comp, aes(x = age, colour = "Complete")) + geom_freqpoly() + 
  geom_freqpoly(data = titanic3.agemis.man, aes(x = fit, colour = "Manhattan")) + 
  geom_freqpoly(data = titanic3.agemis.euc, aes(x = fit, colour = "Euclidean")) + 
  geom_freqpoly(data = titanic3.agemis.p10, aes(x = fit, colour = "p10")) + 
  theme_bw() + ggtitle("Age Distribution by Group k = 1")

plot$labels$colour <- "Group"

plot

## Although the groups are smaller for the imputed vectors they are somewhat similar to the distribution of the complete set.

# Question 3.5

# Reset data
titanicq3 <- titanic3[, c("pclass", "survived", "sex", "age", "sibsp", "parch", "fare")]
set.seed(0)
titanicq3$fare <- impute(titanicq3$fare, "random")
titanicq3.comp <- titanicq3[complete.cases(titanicq3)==TRUE, ]
titanicq3.agemis <- titanicq3[is.na(titanicq3$age), ]
titanicq3.agemis <- titanicq3.agemis[, -4]

sqrt(nrow(titanicq3.comp)) #will use 32 nearest neighbors

# run knn
titanic3.agemis.man <- kknn(age ~ ., titanicq3.comp, titanicq3.agemis, k=32, distance=1)
titanic3.agemis.euc <- kknn(age ~ ., titanicq3.comp, titanicq3.agemis, k=32, distance=2)
titanic3.agemis.p10 <- kknn(age ~ ., titanicq3.comp, titanicq3.agemis, k=32, distance=10)

# convert results of fitted values to dataframe (for ggplot) and rename column to fit
titanic3.agemis.man <- data.frame(titanic3.agemis.man$fitted.values)
names(titanic3.agemis.man)[1] <- "fit"

titanic3.agemis.euc <- data.frame(titanic3.agemis.euc$fitted.values)
names(titanic3.agemis.euc)[1] <- "fit"

titanic3.agemis.p10 <- data.frame(titanic3.agemis.p10$fitted.values)
names(titanic3.agemis.p10)[1] <- "fit"


# Question 3.6

plot <- ggplot(titanicq3.comp, aes(x = age, colour = "Complete")) + geom_freqpoly() + 
  geom_freqpoly(data = titanic3.agemis.man, aes(x = fit, colour = "Manhattan")) + 
  geom_freqpoly(data = titanic3.agemis.euc, aes(x = fit, colour = "Euclidean")) + 
  geom_freqpoly(data = titanic3.agemis.p10, aes(x = fit, colour = "p10")) + 
  theme_bw() + ggtitle("Age Distribution by Group k = 32")

plot$labels$colour <- "Group"

plot

## By increasing the nearest neighbors from 1 to 32, the three methods for knn (manhattan, euclidean and p=10) are more in line with one another.




