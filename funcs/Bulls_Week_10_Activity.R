### Week 10 

install.packages("car")
install.packages("readxl")

library(tidyverse)
library(readxl)
library(dplyr)
library(broom)
library(car)
library(psych)
library(performance)

?performance::check_model

### read in data excel file
df <- read_excel("data/vo2-max_data.xlsx")
View(df)


str(df)
head(df, 10)
tail(df, 10)

summary(df)
describe(df)

### convert gender variable from numeric to categorical variable
df$gender <- as.factor(df$gender)
summary(df$gender)

## visualisations of explanatory variables relates to response variable
## Age v VO2

ggplot(data = df, aes(x = age, y = vo2_max)) +
  geom_point() +
  geom_smooth(method = "lm")
             
## Weight v VO2
ggplot(data = df, aes(x = weight, y = vo2_max)) +
  geom_point() +
  geom_smooth(method = "lm")

#moderate negative trend of VO2_max on weight

## Heart_rate v VO2
ggplot(data = df, aes(x = heart_rate, y = vo2_max)) +
  geom_point() +
  geom_smooth(method = "lm")

## Gender v VO2 - box plot
ggplot(data = df, aes(x = gender, y = vo2_max)) +
  geom_boxplot(aes(fill = gender)) +
  scale_fill_discrete(name = "Gender", labels = c("O = Female", "1 = Male"))

# Gender overlayed scatterplots
## visualisations of explanatory variables relates to response variable
## Age v VO2 with Gender

ggplot(data = df, aes(x = age, y = vo2_max, colour = gender)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Gender", labels = c("O = Female", "1 = Male"))

## Weight v VO2
ggplot(data = df, aes(x = weight, y = vo2_max, colour = gender)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Gender", labels = c("O = Female", "1 = Male"))

#moderate negative trend of VO2_max on weight

## Heart_rate v VO2
ggplot(data = df, aes(x = heart_rate, y = vo2_max, colour = gender)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Gender", labels = c("O = Female", "1 = Male"))

## search for multicollinearity.
pairs(formula = ~ age + weight + heart_rate, data = df)

## multiple linear regression, VO2_max based on age, gender, weight and hear_rate

# what is the interpretable "real world" picture of the intercept and slope coefficients
library(broom)
fit <- lm(vo2_max ~ age + weight + heart_rate + gender, data = df)
tidy(fit, conf.int = TRUE)

summary(fit)

# intercept coefficient = when all continuous explanatory variables are equal to 0, and when gender is female, 
# the estimated VO2max is 87.8 ml/kg/min
# slope coef for age = when age is increased by 1 year, VO2max decreases by 0.165ml/kg/min, when all other variables remain fixed
# slope coef for weight = when weight is increased by 1kg, VO2max decreases by 0.384 ml/kg/min, when all other variables remain fixed
# slope coef for heart_rate = when HR is increased by 1 bpm, VO2max decreases by 0.118 ml/kg/min, when all other variables remain fixed
# males have a VO2max that is 13.2 ml/kg/min higher on average, than females, when all other variables remain fixed. 

### Independence testing
car::durbinWatsonTest(fit)

# possible answer 
# We can tell from our study design that we do not have independence of observations
# as we are just analysing single participants and there are no repeated measures
# nonetheless, we can also test that our residuals are not autocorrelated with the DW test
# our results are 1.9, which is close to the recommended 2 to ensure independence. 
# Thus we have not failed this assumption. 

## Outliers assessment

std_res <- rstandard(fit)
points <- 1:length(std_res)

ggplot(data = NULL, aes(x = points, y = std_res)) +
  geom_point() +
  ylim(c(-4,4)) +
  geom_hline(yintercept = c(-3, 3), colour = "red", linetype = "dashed")

## Yes, some outliers are present, as there are values close to 3

res_labels <- if_else(abs(std_res) >= 2.5, paste(points), "")

ggplot(data = NULL, aes(x = points, y = std_res, label = res_labels)) +
  geom_point() +
  geom_text(nudge_x = 2) +
  ylim(c(-4,4)) +
  geom_hline(yintercept = c(-3, 3), colour = "red", linetype = "dashed")

# Points identified 28, 54, 41 as outliers

# Leverage Points
hats <- hatvalues(fit)

ggplot(data = NULL, aes(x = points, y = hats)) +
  geom_point()

# there are no hatvalues greater than 1, however we might investigate the points above 0.15 
# as they seem to stick out above the rest

## creation of hat labels for outliers > 0.15
hat_labels <- if_else(hats >= 0.15, paste(points), "")

ggplot(data = NULL, aes(x = points, y = hats)) +
  geom_point() +
  geom_text(aes(label = hat_labels), nudge_y = 0.005)

## points 2 and 61 identified as outliers

## Influential point identification

cook <- cooks.distance(fit)

ggplot(data = NULL, aes(x = points, y = cook)) + 
  geom_point()

# we might take a look at those points above 0.075 that are standing out above the rest

## Assessment of 0.075

cook_labels <- if_else(cook >= 0.075, paste(points), "")

ggplot(data = NULL, aes(x = points, y = cook)) +
  geom_point() +
  geom_text(aes(label = cook_labels), nudge_x = 2)

## Identified 25,28,32,35,41,73 as outliers

outliers <- c(25, 28, 32, 35, 41, 73)
filtered_df <- df %>%
  filter(!subject_id %in% outliers) ## filter subject_id that (!) is not in outliers


## re-run of linear regression with filtered_df
fit2 <- lm(vo2_max ~ age + weight + heart_rate + gender, data = filtered_df)
tidy(fit2, conf.int = TRUE)

summary(fit2)

# removing these points has changed both the slope coefficient for weight, gender and the intercept coefficients quite a bit
# the R-squared value has improved by quite a lot, however we should be careful about removing outliers/influential data points that
# are real values as they can introduce bias into the model.
# we should check the outliers/influential data points to ensure that they are not due to measurement errors
# if they are not due to measurement errors we might consider transforming the variables and re-running the model, or choosing a different model type that is more robust to these points. Removing real data should be a last option

## Homoscedasticity

# we can test for heteroscedasticity by plotting the residuals against 
# the fitted values

res <- residuals(fit)
fitted <- predict(fit) 

ggplot(data = NULL, aes(x = fitted, y = res)) +
  geom_point(colour = "dodgerblue") +
  geom_hline(yintercept = 0, colour = "red", linetype = "dashed")

# there does not appear to be evidence of heteroscedasticity 


# Looking for normality in residual values

ggplot(data = NULL, aes(x = res)) +
  geom_histogram(colour = "black", fill = "dodgerblue", binwidth = 4)

### distribution looks normal, with possible long tails either end.

ggplot(data = NULL, aes(sample = res)) +
  stat_qq() + stat_qq_line()

# Perhaps some longer tails at either end. 
# To fix this we could transfrom our data


# Test for multicollinearity 
car::vif(fit)

# All vif values are quite close to 1 so does not appear to be any 
# multicollinearity influencing the standard errors of the coefficients


## Linearity

car::avPlots(fit)

# Some points are tending to create non-linear patterns in the data, they seem to be similar to the points
# that may have been points of high influence.
# We could try transforming our data or investigate the use of a different model that is more robust to our data

# Step 15. Interpretation:
# estimated VO2max = 87.8 + age x -0.165 + weight x -0.385 + heart rate x -0.118 + gender x 13.2

# estimated VO2max 
87.8 + 31 * -0.165 + 68 * -0.385 + 140 * -0.118 + 0 * 13.2 ## information comes from the summary(fit)


# Some of our assumptions may have been violated and we potentially need to apply a transformation (e.g. log transformation) to our 
# explanatory variables, response variable or both
# we should investigate non-linear models that could be more robust to the data we have as well
# we should also investigate the level of error in our estimates (i.e. difference between observed and predicted values)




    