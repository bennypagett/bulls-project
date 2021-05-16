## Chicago Bulls - Multiple linear regressions
## Using df_nonTOT_clean


library(tidyverse)
library(ggplot2)
library(readr)
library(dplyr)
library(broom)
library(performance)
library(psych)
library(ggrepel)


##Read in data
df_nonTOT_clean <- read_csv("data/tidy_data/df_nonTOT_clean.csv")
view(df_nonTOT_clean)

df_TOT_players <- read_csv("data/tidy_data/df_TOT_players.csv")
View(df_TOT_players)

player_stats_tidy <- read_csv("data/tidy_data/player_stats_tidy.csv")
View(player_stats_tidy)

## relocate PTS_per_MP and PTS_per_game
df_nonTOT_clean <- df_nonTOT_clean %>%
  relocate(PTS_per_MP, .after = eFGp)
df_nonTOT_clean <- df_nonTOT_clean %>%
  relocate(PTS_per_game, .after = PTS_per_MP)

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

head(df_nonTOT_clean, 20)

df_nonTOT_clean <- df_nonTOT_clean %>%
  filter(df_nonTOT_clean$G >= 10)

## Change Pos to factor (C = 1, PF = 2, PG = 3, SF = 4, SG = 5)
df_nonTOT_clean$Pos <- as.factor(df_nonTOT_clean$Pos)
str(df_nonTOT_clean$Pos)

table(df_nonTOT_clean$Pos)
levels(df_nonTOT_clean$Pos)

  ## eFG and Team Wins
ggplot(df_nonTOT_clean, aes(x = eFGp, y = WinP_Tm)) +
  geom_point(alpha = 0.5, colour = "purple") +
  geom_smooth(method = "lm")

## PTS_per_MP vs WinP_TM
ggplot(df_nonTOT_clean, aes(x = PTS_per_MP, y = WinP_Tm)) +
  geom_point(alpha = 0.5, colour = "magenta") +
  geom_smooth(method = "lm")

### eFG% vs PTS_per_MP
ggplot(df_nonTOT_clean, aes(x = PTS_per_MP, y = eFGp)) +
  geom_point(alpha = 0.5, colour = "magenta") +
  geom_smooth(method = "lm")

### TrV vs PTS_per_MP
ggplot(df_nonTOT_clean, aes(x = PTS_per_MP, y = TrV)) +
  geom_point(alpha = 0.5, colour = "dodgerblue") +
  geom_smooth(method = "lm")

### eFF vs W
ggplot(df_nonTOT_clean, aes(x = EFF, y = WinP_Tm)) +
  geom_point(alpha = 0.5, colour = "magenta") +
  geom_smooth(method = "lm")

### Tm_use_total vs WinP_Tm
ggplot(df_nonTOT_clean, aes(x = Tm_use_total, y = WinP_Tm)) +
  geom_point(alpha = 0.5, colour = "magenta") +
  geom_smooth(method = "lm")

## PTS_per_game vs WinP_Tm
ggplot(df_nonTOT_clean, aes(x = PTS_per_game, y = WinP_Tm)) +
  geom_point(alpha = 0.5, colour = "green") +
  geom_smooth(method = "lm")

## PTS_per_MP vs WinP_Tm
ggplot(df_nonTOT_clean, aes(x = PTS_per_MP, y = WinP_Tm)) +
  geom_point(alpha = 0.5, colour = "green") +
  geom_smooth(method = "lm")

### STL_MP vs WinP_Tm
ggplot(df_nonTOT_clean, aes(x = STL_MP, y = WinP_Tm)) +
  geom_point(alpha = 0.5, colour = "red") +
  geom_smooth(method = "lm")

### TOV_MP vs WinP_Tm
ggplot(df_nonTOT_clean, aes(x = TOV_MP, y = WinP_Tm)) +
  geom_point(alpha = 0.5, colour = "magenta") +
  geom_smooth(method = "lm")

## Age vs EFF
ggplot(df_nonTOT_clean, aes(x = Age, y = EFF)) +
  geom_point(alpha = 0.5, colour = "magenta") +
  geom_smooth(method = "lm")

## Age vs eFGp
ggplot(df_nonTOT_clean, aes(x = Age, y = eFGp)) +
  geom_point(alpha = 0.5, colour = "magenta") +
  geom_smooth(method = "lm")

## Age vs Tm_use_total
ggplot(df_nonTOT_clean, aes(x = Age, y = Tm_use_total)) +
  geom_point(alpha = 0.5, colour = "magenta") +
  geom_smooth(method = "lm")

##Box plot of position vs PTS_per_MP
ggplot(data = df_nonTOT_clean, aes(x = Pos, y = PTS_per_MP)) +
  geom_boxplot(aes(fill = Pos)) +
  scale_fill_discrete(name = "Pos", labels = c("1 = C", "2 = PF", "3 = PG","4 = SF", "5 = SG"))

## with assesment including Pos
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
##### simple linear regression eFGp and WinP_Tm shows strong-moderate increase in WinP_Tm

## eFGp vs WinP_Tm with Pos
ggplot(data = df_nonTOT_clean, aes(x = Age, y = WinP_Tm, colour = Pos)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Pos", labels = c("1 = C", "2 = PF", "3 = PG","4 = SF", "5 = SG"))

## eFGp vs WinP_Tm with Pos
ggplot(data = df_nonTOT_clean, aes(x = Tm_use_total, y = WinP_Tm, colour = Pos)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Pos", labels = c("1 = C", "2 = PF", "3 = PG","4 = SF", "5 = SG"))
## Teams that may be utilising SG more, may have more TOV and FTA/FGA/eFGp as they aren't converting attempts to PTS. 




## Age vs Tm_use_total with Pos
ggplot(data = df_nonTOT_clean, aes(x = Age, y = Tm_use_total, colour = Pos)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Pos", labels = c("1 = C", "2 = PF", "3 = PG","4 = SF", "5 = SG"))

## EFF vs W with Pos
ggplot(data = df_nonTOT_clean, aes(x = EFF, y = W, colour = Pos)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Pos", labels = c("1 = C", "2 = PF", "3 = PG","4 = SF", "5 = SG"))

## TrV vs W with Pos
ggplot(data = df_nonTOT_clean, aes(x = TrV, y = W, colour = Pos)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Pos", labels = c("1 = C", "2 = PF", "3 = PG","4 = SF", "5 = SG"))

## eFG vs EFF with Pos
ggplot(data = df_nonTOT_clean, aes(x = EFF, y = eFGp, colour = Pos)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Pos", labels = c("1 = C", "2 = PF", "3 = PG","4 = SF", "5 = SG"))

## TRB vs W with Pos
ggplot(data = df_nonTOT_clean, aes(x = TRB, y = W, colour = Pos)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Pos", labels = c("1 = C", "2 = PF", "3 = PG","4 = SF", "5 = SG"))

## TRB_MP vs W with Pos
ggplot(data = df_nonTOT_clean, aes(x = TRB_MP, y = W, colour = Pos)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Pos", labels = c("1 = C", "2 = PF", "3 = PG","4 = SF", "5 = SG"))

## Age vs W with Pos
ggplot(data = df_nonTOT_clean, aes(x = Age, y = W, colour = Pos)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Pos", labels = c("1 = C", "2 = PF", "3 = PG","4 = SF", "5 = SG"))

## Win_PT_MP vs PTS_per_game
ggplot(data = df_nonTOT_clean, aes(x = PTS_per_game, y = WinP_Tm, colour = Pos)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_fill_discrete(name = "Pos", labels = c("1 = C", "2 = PF", "3 = PG","4 = SF", "5 = SG"))

## 

## Variables that show slight significance to increased Wins : TM_use_total, EFF, PTS_per_MP (possible leverage point with game)
## Variables that show increase in TrV: PTS_per_MP,
## Increased PTS_per_MP shows positive trend/increase eFGp 
## Increased Age ~up to 30 shows increased trend of EFF, slight decrease trend in Tm_use_total with increasing Age

## Variables of Position to analyse. SG increase in PTS_per_MP decreased count of W? and Increased Tm_use_total showed decreased W in SG
## Slight down trend with PF. Positive relationship with PG and SF. So SF and PG with high PTS_per_MP

## Typically showing a trend for increase Tm_use with increasing Age in SG, however shows decrease in W for team
## Downward trend of PF and C with Age for Tm_use - typically these positions are a little bit younger due to physical nature
# SF and PG strong relationship of increased W with increase age ~ 30+ish, min to moderate increase with C&PF, decrease wins with Age in SG
## Increased EFF causes increase in W in all except SG. PG and SF are the highest slope angle
## Increased eFGp shows increased relationship with EFF across all positions.
## Increased TRB shows increased W in PG, SF (strong) and slight-moderate in C and PF. With a negative relationship in SG.

# Increased PTS_per_MP shows greater W. Showing in some positions a strong strength relationship.
##Could use correlation coefficient to find figure

lm_bb <- lm(WinP_Tm ~ PTS_per_game, data = df_nonTOT_clean)
tidy(lm_bb, conf.int = TRUE)

lm_bb <- lm(WinP_Tm ~ PTS_per_MP, data = df_nonTOT_clean)
tidy(lm_bb, conf.int = TRUE)

# shows that teams with 0 walks will be able to get 2.17 runs from other means
## team will increase W by 1 PTS_per_MP, we would see 39 W per season increase. with a 95% CI of between 35.1 and 42.81.

## counfounding variables - Positions with large volume of shooting may miss more in the process, 
# so their eFGp may not directly imply a win
## Other factors of game play - requires 5 players to work together to get PTS.Good SG in a bad team, will show possible poor trend of stats/Wins

ggplot(df_nonTOT_clean, aes(x = eFGp, y = PTS_per_MP)) +
  geom_point(alhpa = 0.5, colour = "darkgreen") +
  geom_smooth(method = "lm")

# shows moderate relationship of eFGp and PTS_per_MP

ggplot(df_nonTOT_clean, aes(x = eFGp, y = WinP_Tm)) +
  geom_point(alpha = 0.5, colour = "dodgerblue") +
  geom_smooth(method = "lm")
#strong positive relationship. 

ggplot(df_nonTOT_clean, aes(x = Age, y = WinP_Tm)) +
  geom_point(alpha = 0.5, colour = "dodgerblue") +
  geom_smooth(method = "lm")

ggplot(df_nonTOT_clean, aes(x = EFF, y = WinP_Tm)) +
  geom_point(alpha = 0.5, colour = "dodgerblue") +
  geom_smooth(method = "lm")

ggplot(df_nonTOT_clean, aes(x = PTS_per_MP, y = WinP_Tm)) +
  geom_point(alpha = 0.5, colour = "dodgerblue") +
  geom_smooth(method = "lm")

ggplot(df_nonTOT_clean, aes(x = EFF, y = PTS_per_MP)) +
  geom_point(alpha = 0.5, colour = "dodgerblue") +
  geom_smooth(method = "lm")


## Pairs plot for visualizing relationship between > 2 variables

pairs(formula = ~ WinP_Tm + eFGp + TRB + Tm_use_total + PTS_per_MP + EFF + TrV + Age, data = df_nonTOT_clean)

pairs(formula = ~ PTS_per_MP + eFGp  + EFF + TrV + TRB_MP + Tm_use_total + AST_MP + STL_MP + BLK_MP, data = df_nonTOT_clean)

## HOw many more PTS_per_MP when controlling for other factors

lm_bb_hr <- lm(PTS_per_MP ~ EFF + TrV + TRB_MP + eFGp + Tm_use_total + AST_MP + STL_MP + BLK_MP, data = df_nonTOT_clean)
tidy(lm_bb_hr, conf.int = TRUE)

# CI = -0.329 to -0.276
# Y-intercept = -.302, eFGp = 39.4 and TRB = -0.00846 Tm_use_total -5.72 PTS_per_MP -7.11 
# EFF = 0.0124 TrV = -0.0310  Age = -0.406

#1 (Intercept)  -0.302     0.0134       -22.5   5.41e- 72 -0.329     -0.276     
#2 eFGp          0.612     0.0212        28.8   1.47e- 97  0.570      0.653     
#3 EFF           0.0000302 0.00000417     7.24  2.50e- 12  0.0000220  0.0000384 
#4 TrV          -0.0000211 0.0000101     -2.10  3.67e-  2 -0.0000409 -0.00000132
#5 TRB_MP       -0.0582    0.0191        -3.05  2.46e-  3 -0.0957    -0.0206    
#6 Tm_use_total  2.31      0.0304        76.2   2.86e-232  2.25       2.37      
#7 AST_MP       -0.226     0.0268        -8.41  8.17e- 16 -0.278     -0.173     
#8 STL_MP       -0.169     0.102         -1.65  9.90e-  2 -0.371      0.0320    
#9 BLK_MP       -0.0643    0.0779        -0.826 4.09e-  1 -0.217      0.0888  



## for every 1 increase of eFGp, PTS_per_MP will increase by 39.4

fit <- lm(W ~ eFGp + TRB + Tm_use_total + PTS_per_MP + EFF + TrV + Age,
          data = df_nonTOT_clean)
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




