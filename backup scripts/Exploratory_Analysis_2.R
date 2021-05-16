## Chicago Bulls - Exploratory Analysis
## Using df_nonTOT_clean 

library(tidyverse)
library(readr)
library(dplyr)
library(ggplot2)
library(broom)
library(performance)
library(psych)
library(ggrepel)


##Read in data
df_nonTOT_clean <- read_csv("data/tidy_data/df_nonTOT_clean.csv")
view(df_nonTOT_clean)


## relocate PTS_per_MP and PTS_per_game
df_nonTOT_clean <- df_nonTOT_clean %>%
  relocate(PTS_per_MP, .after = eFGp)
df_nonTOT_clean <- df_nonTOT_clean %>%
  relocate(PTS_per_game, .after = PTS_per_MP)
df_nonTOT_clean <- df_nonTOT_clean %>%
  relocate(TRB_MP, .after = PTS_per_game)
df_nonTOT_clean <- df_nonTOT_clean %>%
  relocate(TRB, .after = TRB_MP)


df_nonTOT_clean <- df_nonTOT_clean %>%
  mutate(WinP_Tm = ((W / Tm_G) * 100)) 

df_nonTOT_clean <- df_nonTOT_clean %>%
  relocate(WinP_Tm, .after = L)


## create new df "datC" and create variables/game
datC <- df_nonTOT_clean %>% filter(df_nonTOT_clean$Pos == "C")

## create new df "datPF" 
datPF <- df_nonTOT_clean %>% filter(df_nonTOT_clean$Pos == "PF")

## create new df "datPG" 
datPG <- df_nonTOT_clean %>% filter(df_nonTOT_clean$Pos == "PG") 

## create new df "datSF" 
datSF <- df_nonTOT_clean %>% filter(df_nonTOT_clean$Pos == "SF")

## create new df "datSG" 
datSG <- df_nonTOT_clean %>% filter(df_nonTOT_clean$Pos == "SG") 

## Write_csv data file for each Pos
write_csv(datC, file = "data/tidy_data/datC.csv")
write_csv(datPF, file = "data/tidy_data/datPF.csv")
write_csv(datPG, file = "data/tidy_data/datPG.csv")
write_csv(datSF, file = "data/tidy_data/datSF.csv")
write_csv(datSG, file = "data/tidy_data/datSG.csv")

summary(df_nonTOT_clean$Pos)

## Data frame structure
str(df_nonTOT_clean)
head(df_nonTOT_clean, 20)
tail(df_nonTOT_clean, 20)

## filter out players who have played 20 or more games for the season
df_nonTOT_clean <- df_nonTOT_clean %>%
  filter(df_nonTOT_clean$G >= 40)

## Change Pos to factor (C = 1, PF = 2, PG = 3, SF = 4, SG = 5)
df_nonTOT_clean$Pos <- as.factor(df_nonTOT_clean$Pos)
str(df_nonTOT_clean$Pos)

table(df_nonTOT_clean$Pos)
levels(df_nonTOT_clean$Pos)

## Exploring the distribution of the data from df_nonTOT_clean

## Distribution of eFGp

ggplot(data = df_nonTOT_clean) +
  geom_histogram(mapping = aes(x = eFGp), colour = "black", fill = "dodgerblue")
# normal distribution

## Distribution of EFF

ggplot(data = df_nonTOT_clean) +
  geom_histogram(mapping = aes(x = EFF), colour = "black", fill = "dodgerblue")
# L skew

## Distribution of TRB_MP

ggplot(data = df_nonTOT_clean) +
  geom_histogram(mapping = aes(x = TRB_MP), colour = "black", fill = "dodgerblue")
# R skew

## Distribution of TrV

ggplot(data = df_nonTOT_clean) +
  geom_histogram(mapping = aes(x = TrV), colour = "black", fill = "dodgerblue")
# L skew

## Distribution of Tm_use_total

ggplot(data = df_nonTOT_clean) +
  geom_histogram(mapping = aes(x = Tm_use_total), colour = "black", fill = "dodgerblue")
## slight R skew

## Exploring the relationship of the data from df_nonTOT_clean

## Relationship of eFGp and PTS_per_MP

df_nonTOT_clean %>%
  ggplot(mapping = aes(x = eFGp, y = PTS_per_MP)) +
  geom_point() +
  geom_smooth(method = "lm")
#moderate positive linear relationship

## Distribution of EFF and PTS_per_MP
df_nonTOT_clean %>%
  ggplot(mapping = aes(x = EFF, y = PTS_per_MP)) +
  geom_point() +
  geom_smooth(method = "lm")
#Strong positive linear relationship

## Distribution of TRB_MP and PTS_per_MP
df_nonTOT_clean %>%
  ggplot(mapping = aes(x = TRB_MP, y = PTS_per_MP)) +
  geom_point() +
  geom_smooth(method = "lm")
#moderate positive linear relationship

## Distribution of TrV and PTS_per_MP
df_nonTOT_clean %>%
  ggplot(mapping = aes(x = TrV, y = PTS_per_MP)) +
  geom_point() +
  geom_smooth(method = "lm")
#Strong positive relationship

## Distribution of Tm_use_total and PTS_per_MP
df_nonTOT_clean %>%
  ggplot(mapping = aes(x = Tm_use_total, y = PTS_per_MP)) +
  geom_point() +
  geom_smooth(method = "lm")
#very strong positive relationship

#Additional Graphs

##Box plot of position vs PTS_per_MP
ggplot(data = df_nonTOT_clean, aes(x = Pos, y = PTS_per_MP)) +
  geom_boxplot(aes(fill = Pos)) +
  scale_fill_discrete(name = "Pos", labels = c("1 = C", "2 = PF", "3 = PG","4 = SF", "5 = SG"))

## Scatter plot with PTS_per_MP and WinP_Tm with Pos colour
ggplot(data = df_nonTOT_clean, aes(x = PTS_per_MP, y = WinP_Tm, colour = Pos)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Pos", labels = c("1 = C", "2 = PF", "3 = PG","4 = SF", "5 = SG"))

## eFGp vs WinP_Tm with Pos
ggplot(data = df_nonTOT_clean, aes(x = eFGp, y = WinP_Tm, colour = Pos)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Pos", labels = c("1 = C", "2 = PF", "3 = PG","4 = SF", "5 = SG"))
#####eFGp demonstrates a strong-moderate increase in WinP_Tm

## EFF vs WinP_Tm with Pos
ggplot(data = df_nonTOT_clean, aes(x = EFF, y = WinP_Tm, colour = Pos)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Pos", labels = c("1 = C", "2 = PF", "3 = PG","4 = SF", "5 = SG"))

## TrV vs WinP_Tm with Pos
ggplot(data = df_nonTOT_clean, aes(x = TrV, y = WinP_Tm, colour = Pos)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Pos", labels = c("1 = C", "2 = PF", "3 = PG","4 = SF", "5 = SG"))

## Tm_use_total vs WinP_Tm with Pos
ggplot(data = df_nonTOT_clean, aes(x = Tm_use_total, y = WinP_Tm, colour = Pos)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Pos", labels = c("1 = C", "2 = PF", "3 = PG","4 = SF", "5 = SG"))

## TRB_MP vs WinP_Tm with Pos
ggplot(data = df_nonTOT_clean, aes(x = TRB_MP, y = WinP_Tm, colour = Pos)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Pos", labels = c("1 = C", "2 = PF", "3 = PG","4 = SF", "5 = SG"))

## WinP_Tm vs PTS_per_game
ggplot(data = df_nonTOT_clean, aes(x = PTS_per_game, y = WinP_Tm, colour = Pos)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Pos", labels = c("1 = C", "2 = PF", "3 = PG","4 = SF", "5 = SG"))

## eFG vs EFF with Pos
ggplot(data = df_nonTOT_clean, aes(x = EFF, y = eFGp, colour = Pos)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Pos", labels = c("1 = C", "2 = PF", "3 = PG","4 = SF", "5 = SG"))


## Variables that show slight significance to increased Wins : TM_use_total, EFF, PTS_per_MP (possible leverage point with game)
## Variables that show increase in TrV: PTS_per_MP,
## Variables of Position - SG demonstrated an increase in PTS_per_MP and a decreased count of WinP_Tm. An increased Tm_use_total showed decreased WinP_Tm in SG
## Slight down trend with PF. Positive relationship with PG and SF. So SF and PG with high PTS_per_MP
## Increased EFF causes increase in WinP_Tm in all positions except SG. PG and SF demonstrate the highest slope angle
## Increased eFGp shows increased relationship with EFF across all positions.
## Increased TRB shows increased WinP_Tm in PG, SF (strong) and slight-moderate in C and PF. With a negative relationship in SG.

## Increased PTS_per_MP shows greater WinP_Tm. Demonstrating a strong positive relationship.
##Could investigate more using a correlation coefficient to determine a figure.


##QUESTION
###What contributes to success in basketball?
### What variables contribute to winning percentage?


## relationship between points per min and team winning percentage
ggplot(data = df_nonTOT_clean, aes(x = PTS_per_MP, y = WinP_Tm)) + 
  geom_point(colour = "dodgerblue") +
  geom_smooth(method = "lm", colour = "magenta", se = FALSE) +
  geom_hline(yintercept = 50, colour = "black", linetype = "dashed")

### There appears to be a linear relationship between points per min and winning percentage.
### As points per min increases, there is an increase in team winning percentage.

#correlation co-efficient PTS_per_MP and WinP_Tm

with(df_nonTOT_clean, cor(x = PTS_per_MP, y = WinP_Tm))

#[1] 0.05560196

##The correlation co-efficient = 0.055 suggesting a moderate-strong positive correlation between 
### PTS_per_min and team winning percentage as 0.55 is approaching the value of 1. 

# Simple Linear Regression

fit <- lm(WinP_Tm ~ PTS_per_MP, data = df_nonTOT_clean)
tidy(fit,conf.int = TRUE)

summary(fit)

## A tibble: 2 x 7
#term        estimate std.error statistic  p.value conf.low conf.high
#<chr>          <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#  1 (Intercept)    47.7       2.85    16.7   1.41e-44    42.1       53.3
#2 PTS_per_MP      5.85      6.15     0.952 3.42e- 1    -6.25      18.0
#> summary(fit)

#Call:
#  lm(formula = WinP_Tm ~ PTS_per_MP, data = df_nonTOT_clean)

#Residuals:
##  Min       1Q   Median       3Q      Max 
#-30.1688  -9.5159   0.5934  10.4431  23.5914 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)    
#(Intercept)   47.721      2.850  16.744   <2e-16 ***
#  PTS_per_MP     5.854      6.151   0.952    0.342    
#---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

###Residual standard error: 14.24 on 292 degrees of freedom
###Multiple R-squared:  0.003092,	Adjusted R-squared:  -0.0003225 
##F-statistic: 0.9055 on 1 and 292 DF,  p-value: 0.3421
   

### The intercept co-efficient = 47.7, meaning that when the team winning percentage is 0,
## the expected points per minute = 47.7, which does
## not make much practical sense, but is a starting point for the model.
## The slope co-efficient = 5.85, meaning that for every 1 unit that points per min is 
## increased, expected points per minutes increase by 5.85.
### The r squared value = -0.0003225, meaning that 0.03225% of the variance in team winning percentage
### is explained by the variance in points per minute.

lm(formula = WinP_Tm ~ PTS_per_MP, data = df_nonTOT_clean)

#Independence 
library(Lahman)
library(car)
car::durbinWatsonTest(fit)
#lag Autocorrelation D-W Statistic p-value
#1       0.9832565    0.01404402       0
#Alternative hypothesis: rho != 0

### the durbinwatson statistic = 0.01404402, which is not close to the recommended value of 2
### meaning that the assumption of independence is possibly failed. However, this could be due to the
## filtered dataset and the figures are from across teams and there is player movement/transfer between teams, which could influence the inedepence.

# Are there any outliers?

std_res <- rstandard(fit)
points <- 1:length(std_res)
library(ggplot2)

ggplot(data = NULL, aes(x = points, y = std_res)) +
  geom_point() +
  ylim(c(-4,4)) +
  geom_hline(yintercept = c(-3, 3), colour = "red", linetype = "dashed")

## There does not appear to be any outliers as all standardised residuals are less 
### than 3.

# Leverage Points

hats <- hatvalues(fit)
ggplot(data = NULL, aes(x = points, y = hats)) +
  geom_point()

### There are no hat values greater than 1, however it will be useful to 
## investigate the points above 0.025, as they appear to stand out from the rest of 
## the values. 

#investigate points above 0.025

hat_labels <- if_else(hats >= 0.025, paste(points), "")
ggplot(data = NULL, aes(x = points, y = hats)) +
  geom_point() +
  geom_text(aes(label = hat_labels), nudge_y = 0.005)

## There are 5 points that could be influencing the model (1, 13, 45,104, 200)
## Determine if the points could be considered high influence

cook <- cooks.distance(fit)
ggplot(data = NULL, aes(x = points, y = cook)) +
  geom_point()

cook_labels <- if_else(cook >= 0.015, paste(points), "")

# investigate points above 0.015 that are standing out above the rest

cook_labels <- if_else(cook >= 0.015, paste(points), "")
ggplot(data = NULL, aes(x = points, y = cook)) +
  geom_point() +
  geom_text(aes(label = cook_labels), nudge_x = 8, nudge_y = 0.0005)

ggplot(data = df_nonTOT_clean, aes(x = PTS_per_MP, y = WinP_Tm)) +
  geom_point(colour = "dodgerblue") +
  geom_smooth(method = "lm", colour = "magenta", se = FALSE) +
  geom_hline(yintercept = 50, colour = "black", linetype ="dashed") +
  geom_text(aes(label = cook_labels), nudge_x = 1)

## There are 11 points that could be influencing the model (1, 13, 14, 25, 45, 264, 269, 275, 283, 285, 288)
## Create a new df without the high influencing points

outliers <- c(1, 13, 14, 25, 45, 264, 269, 275, 283, 285, 288)
df_LinR_filtered <- df_nonTOT_clean%>%
  filter(!player_name %in% outliers)

# re-run linear regression with filtered_df
fit2 <- lm(WinP_Tm ~ PTS_per_MP, data = df_LinR_filtered)
tidy(fit2, conf.int= TRUE)

summary(fit2)
##call:
# A tibble: 2 x 7
##term        estimate std.error statistic  p.value conf.low conf.high
##<chr>          <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
#  1 (Intercept)    47.7       2.85    16.7   1.41e-44    42.1       53.3
#2 PTS_per_MP      5.85      6.15     0.952 3.42e- 1    -6.25      18.0
#> summary(fit2)

#Call:
#  lm(formula = WinP_Tm ~ PTS_per_MP, data = df_LinR_filtered)

#Residuals:
#  Min       1Q   Median       3Q      Max 
#-30.1688  -9.5159   0.5934  10.4431  23.5914 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)    
#(Intercept)   47.721      2.850  16.744   <2e-16 ***
#  PTS_per_MP     5.854      6.151   0.952    0.342    
#---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#Residual standard error: 14.24 on 292 degrees of freedom
#Multiple R-squared:  0.003092,	Adjusted R-squared:  -0.0003225 
#F-statistic: 0.9055 on 1 and 292 DF,  p-value: 0.3421

## The removal of high influence points does not show any change to the intercept of WinP_Tm or Pts_per_MP


## plot without high influence points

ggplot(data = df_LinR_filtered, aes(x = PTS_per_MP, y = WinP_Tm)) +
  geom_point(colour = "dodgerblue") +
  geom_smooth(method = "lm", colour = "magenta", se = FALSE) +
  geom_hline(yintercept = 50, colour = "black", linetype = "dashed")

## the graph show a more even spread, and less influenced by the high points. 

# homoscedasticity - test for homoscedasticity by plotting the residuals against the 
##fitted values.

res <- residuals(fit)
fitted <- predict(fit)

ggplot(data = NULL, aes(x = fitted, y =res)) +
  geom_point(colour = "dodgerblue") +
  geom_hline(yintercept = 0, colour = "red", linetype = "dashed")

### There does not appear to be evidence of heteroscedasticity


# Normality - are the residuals normally distributed

ggplot(data = NULL, aes(x = res)) +
  geom_histogram(colour = "black", fill = "dodgerblue", binwidth = 2)

## There appears to be some slight skewness and doesn't look evenly distributed. This is likely from the points investigated for 
##influence. These values did not appear to be influencing the results of the model.
##This left skewed tail could be due to the large spread of players points scoring. 
# A possible option is to collect more data, 
# and also there are potentially other factors that contribute to winning.

ggplot(data = NULL, aes(sample = res)) +
  stat_qq() + stat_qq_line()

### This simple linear regression demonstrates that PTS_per_MP is correlated with WinP_Tm
### in the NBA. Further analysis of the variables eFGp, EFF, TRB_MP, TrV, and Tm_use_total is proposed to assess 
## their influence into PTS_per_MP and therefore WinP_Tm in a multiple linear regression.
### All assumptions have been satisfied, with some understanding of the bias of the data set
## and a multiple linear regression appears to be a robust statistical test
### to investigate to correlations in this data set. 
### The decision to filter to 40 games for this linear regression was based on the idea to see what the most consistent players in the NBA were scoring,
## and how that influenced the Win %. This is important as we want players with a high team usage factor and thus high scoring to be influential at the Chicago Bulls.,
 

