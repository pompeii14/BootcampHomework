# Simple Linear Regression Homework
# Joe Eckert
# 20151007

# Question 1.1

library(MASS)
library(car)
cats <- cats
plot(cats$Bwt, cats$Hwt, xlab = "Body weight", ylab = "Heart weight", main = "Body weight vs Heart weight")

## Looking at the simple scatter plot it appears that a simple linear regression would be a good fit for this data because as the body weight increases there appears to be a relative increase in the heart weight.

# Question 1.2

catslm <- lm(Hwt ~ Bwt, data = cats)
summary(catslm)

## a - Hwt = 4.03(Hwt) - 0.36
## b - the intercept of -0.36 says that when the body weight is 0 we would expect a heart weight of -0.36, which intuitively does not make sense.  The slope coefficient on body weight is 4.03 means that for an increase of 1kg in body weight the heart weight will increase by 4.03g.
## c - according to the linear model, the intercept coefficient is not significant (p value = .6), however the slope coefficient is highly significant (p value ~0)
## d - the overall linear model is significant as the p value for the F test is less than 0.05.  This relates to part c because the slope coefficient is highly significant
## e - the RSE is 1.452 which is low, indicating that the linear model has a relatively good fit
## f - the coefficient of determination is 64.7%, which means that 64.7% of the varience in heart weight is attributed to body weight

# Question 1.3

abline(catslm, lty = 2, col = "red")

# Question 1.4

resid <- residuals(catslm)
pred <- predict(catslm)
segments(cats$Bwt, cats$Hwt, cats$Bwt, pred, col = "red")

## The residual for the observation with the highest heart weight is abnormally large

# Question 1.5

confint(catslm)

## Confidence interval for the intercept is -1.72 to 1.01 and the confidence interval for the body weight coefficient is 3.54 and 4.53.  Based on the sample data we would assume with 95% confidence that the true coefficient for body weight is between 3.54 and 4.53

# Question 1.6

## Linearity - looking at the original plot of the data from question 1.1 the data appears to have a linear quality.

plot(catslm$fitted, catslm$residuals, xlab = "Fitted Values", ylab = "Residual Values", main = "Residual Plot for Cats")
abline(h = 0, lty = 2, col = "red")

## Constant Variance - For the most part variance appears to be constant, however as heart weight is greater than 14 it appears that the errors are increasing

## Independent Errors - the plot also appears to show that the errors are independent from one another

qqnorm(catslm$residuals)

## Normality - the QQ plot shows a straight line, which means that the error terms are likely drawn from an identical gaussian distribution at each value of the explanatory variable


# Question 1.7

plot(cats$Bwt, cats$Hwt, xlab = "Body weight", ylab = "Heart weight", main = "Body weight vs Heart weight")
abline(catslm, lty = 2, col = "green")

newdata <- data.frame(Bwt = 0:4)
conf.band <- predict(catslm, newdata, interval = "confidence")
pred.band <- predict(catslm, newdata, interval = "predict")

lines(newdata$Bwt, conf.band[,2], col = "blue")
lines(newdata$Bwt, conf.band[,3], col = "blue")
lines(newdata$Bwt, pred.band[,2], col = "red")
lines(newdata$Bwt, pred.band[,3], col = "red")
legend("topleft", c("Regression Line", "Conf. Band", "Pred Band"), lty = c(2, 1), col = c("green", "blue", "red"))

## The confidence interval shows where you would expect the true mean of the data to be.  The predicition interval shows where you would expect future observations to show up when randomly sampling the population.  Because the confidence mean is based on the mean it is a tighter range than the prediciton interval.

## The confidence bands get wider as you move away from the center of the line because the line is set to pivot on the central value and the slope of the line varys based on the sample selected

# Question 1.8

newdata <- data.frame(Bwt = c(2.8, 5, 10))
predict(catslm, newdata, interval = "confidence")
predict(catslm, newdata, interval = "predict")

## There is an issue in reporting the intervals for 5kg and 10kg.  In both cases there are no observations in our sample set with body weights greater than 3.9kg, therefore the model doesnt have sufficient information to predict the heart weight as the confidence interval is much wider.


# Question 2.1

catsbc <- boxCox(catslm)

# Question 2.2

lambda = catsbc$x[which(catsbc$y == max(catsbc$y))]

## Best lambda to use is 0.1

# Question 2.3

## Transform the data based on the optimal lambda
catsbcT <- cats
catsbcT$Hwt <- (cats$Hwt^lambda - 1)/lambda

# Question 2.4

## Construct a new regression on the transformed data

catslmBC <- lm(Hwt ~ Bwt, data = catsbcT)

# Question 2.5

plot(Hwt ~ Bwt, data = catsbcT, xlab = "Transformed Body weight", ylab = "Heart weight")
abline(catslmBC, lty = 2, col = "green")

# Question 2.6

summary(catslmBC)
plot(catslmBC)

## There appears to be an issue with the QQ plot, which may signal a violation of the normality assumption

# Question 2.7

## The original model is easier to interpret than the box-cox transformed model, however there is a violation of the constant variance assumption

## The box cox transformation has a higher R^2 value, but the model isnt as easily interpreted by the user


# Question 2.8

catslmBC2 <- boxCox(catslmBC)

