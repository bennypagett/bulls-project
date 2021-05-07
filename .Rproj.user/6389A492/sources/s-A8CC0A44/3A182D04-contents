## Baseball - Multiple linear regressions


library(Lahman)
library(tidyverse)
library(broom)
library(dplyr)
library(performance)
library(psych)

Lahman::Teams

data(Teams)

## create new df "dat" and create variables/game
dat <- Teams %>% filter(between(yearID, 1996, 2015)) %>%
  mutate(HR_per_game = HR / G,
         R_per_game = R / G,
         SB_per_game = SB / G,
         BB_per_game = BB / G,
         S_per_game = (H-HR-X2B-X3B)/G,
         D_per_game = X2B / G,
         T_per_game = X3B / G)

summary(dat$yearID)

## stolen bases and runs
ggplot(dat, aes(x = SB_per_game, y = R_per_game)) +
  geom_point(alhpa = 0.5, colour = "purple") +
  geom_smooth(method = "lm")

## walks vs runs
ggplot(dat, aes(x = BB_per_game, y = R_per_game)) +
  geom_point(alhpa = 0.5, colour = "magenta") +
  geom_smooth(method = "lm")

# more walks per game are seeing greater total runs per game. Showing a moderate strength relationship.
##Could use correlation coefficient to find figure

lm_bb <- lm(R_per_game ~ BB_per_game, data = dat)
tidy(lm_bb, conf.int = TRUE)

# shows that teams with 0 walks will be able to get 2.17 runs from other means
## team will increase walks by 1, we would see .752 runs per game increase. with a 95% CI of between 1.92 and 2.41.

## counfounding variables - HR hitters get more walks. Due to pitchers purposely 
# pitching outside of strike zone.

ggplot(dat, aes(x = HR_per_game, y = BB_per_game)) +
  geom_point(alhpa = 0.5, colour = "darkgreen") +
  geom_smooth(method = "lm")

# shows some relationship of HR and walks

ggplot(dat, aes(x = HR_per_game, y = R_per_game)) +
  geom_point(alhpa = 0.5, colour = "dodgerblue") +
  geom_smooth(method = "lm")
#strong positive relationship. 


## Pairs plot for visualising relationship between > 2 variables

pairs(formula = ~R_per_game + BB_per_game + HR_per_game, data = dat)

## HOw many more R_per_game when controlling BB_per_game

lm_bb_hr <- lm(R_per_game ~ BB_per_game + HR_per_game, data = dat)
tidy(lm_bb_hr, conf.int = TRUE)

# CI = 1.45 - 1.85
# Y-intercept = 1.65, BB_per_game = 0.476 and HR_per_game = 1.37

## for every 1 increase of BB_per_game, R_per_game will increase by .476

fit <- lm(R_per_game ~ BB_per_game + HR_per_game + S_per_game + D_per_game + T_per_game,
          data = dat)
tidy(fit, conf.int = TRUE)


### Predicted value formula important to remember

# as such if 
#HR_per_game = 1.5
#BB_per_game = 3.5
#S_per_game = 6.2
#D_per_game = 2.2
#T_per_game = 0.2
-3.00 + 0.358 * 1.5 + 1.481 * 3.5 + 0.564 * 6.2 + 0.730 * 2.2 + 1.270 * 0.2
## = 8.0773


## can use head(predict(fit)) to give summary of top 6 using prediction formula without specifically saying which values to use.

### avPlot used to assess R_per_game against all other variables.
car::avPlots(fit)

### multicollinearity can be done by hand using a pairs plot. We want some relationship,
# however not a direct linear relationship

#VIF - variance inflation factor.
car::vif(fit)
# next step - need to square root output to find actual variance

sqrt(car::vif(fit))

# looking aware for values close to 5 for VIF as would imply high multicolinearity


## can use model to then fit into model.

new_dat <- Teams %>% 
  filter(yearID == 2016) %>%
  mutate(HR_per_game = HR / G,
         R_per_game = R / G,
         SB_per_game = SB / G,
         BB_per_game = BB / G,
         S_per_game = (H-HR-X2B-X3B)/G,
         D_per_game = X2B / G,
         T_per_game = X3B / G)

summary(new_dat$yearID)
### New varaiable creation
new_dat <- mutate(new_dat, exp_R_per_game = predict(fit, newdata = new_dat))

view(new_dat)

## model testing
ggplot(new_dat, aes(exp_R_per_game, R_per_game, label = teamID)) +
  geom_point(colour = "dodgerblue") +
  geom_text(nudge_x = 0.1, cex = 3) +
  geom_abline(linetype = "dashed", colour = "magenta")

## dashed line is if everything was predicted correctly, would line up on line
# points above the line - under estimated, below the line = over estimated

# Looking at correlation of Wins to exp_R_game

ggplot(new_dat, aes(x = W, y = exp_R_per_game, label = teamID)) +
  geom_point(colour = "dodgerblue") +
  geom_text(nudge_x = 2, cex = 3)
  
## creating player metric, player specific (some confounding issues to player details, need to normalise to the opportunities a player gets)

pa_per_game <- Batting %>%
  filter(yearID == 2016) %>%
  group_by(teamID) %>%
  summarise(pa_per_game = sum(AB + BB + HBP + SF + SH)/max(G)) %>%
  pull(pa_per_game) %>%
  mean

pa_per_game

### also to include other player
players <- Batting %>% filter(between(yearID, 2011, 2015)) %>%
  group_by(playerID) %>%
  mutate(PA = AB + BB + HBP + SF + SH)

head(players, 10)

## now for plate appearances rate

players <- players %>%
  summarise(G = sum(PA) / pa_per_game,
            BB_per_game = sum(BB) / G, 
            S_per_game = sum(H-X2B-X3B-HR) / G,
            D_per_game = sum(X2B) / G, 
            T_per_game = sum(X3B) / G, 
            HR_per_game = sum(HR) / G,
            BA_per_game = sum(H) / sum(AB),
            PA = sum(PA)) %>%
  filter(PA >= 200) %>%
  select(-G)

players


## Expected runs player metric

players <- mutate(players, exp_Runs = predict(fit, newdata = players))

players %>%
  ggplot(aes(x = exp_Runs)) +
  geom_histogram(binwidth = 0.5, colour = "black", fill = "dodgerblue")

## adding salary and position

players <- Salaries %>%
  filter(yearID == 2016) %>%
  select(playerID, salary) %>%
  right_join(players, by = "playerID")

view(players)

## now to assess data frame
players %>% 
  select(nameFirst, nameLast, POS, salary, exp_Runs) %>% 
  arrange(desc(exp_Runs), salary) %>%
  top_n(10)


## scatter plot

players %>% ggplot(aes(x = salary/1000000, y = exp_Runs, color = POS)) + 
  geom_point() +
  xlab("Salary (Millions)")




