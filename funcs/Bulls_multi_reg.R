## Chicago Bulls - Multiple linear regressions
## Using df_nonTOT_clean looking at PTS_per_MP

install.packages(plotly)

library(tidyverse)
library(ggplot2)
library(readr)
library(dplyr)
library(broom)
library(performance)
library(psych)
library(ggrepel)
library(plotly)
library(GGally, quietly = TRUE)



##Read in data
df_nonTOT_clean <- read_csv("data/tidy_data/df_nonTOT_clean.csv")



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

head(df_nonTOT_clean, 20)

df_nonTOT_clean <- df_nonTOT_clean %>%
  filter(df_nonTOT_clean$G >= 40)

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

lm_bb <- lm(PTS_per_MP ~ EFF, data = df_nonTOT_clean)
tidy(lm_bb, conf.int = TRUE)

# shows that players with 0 Pts_per_MP will be able to get 0.273 Pts_per_MP from other means
## Players who's EFF increase by 1, we would see 0.000178 increase of PTS_per_MP. with a 95% CI of between 0.253 and 0.293.

## counfounding variables - Positions with large volume of shooting may miss more in the process, 
# so their eFGp may not directly imply a win
## Other factors of game play - requires 5 players to work together to get PTS.Good SG in a bad team, will show possible poor trend of stats/Wins
## Good SG in a bad team, will show poor results due to player working hard, but not winning games.

ggplot(df_nonTOT_clean, aes(x = eFGp, y = PTS_per_MP)) +
  geom_point(alpha = 0.5, colour = "darkgreen") +
  geom_smooth(method = "lm")

# shows moderate relationship of eFGp and PTS_per_MP

ggplot(df_nonTOT_clean, aes(x = eFGp, y = WinP_Tm)) +
  geom_point(alpha = 0.5, colour = "dodgerblue") +
  geom_smooth(method = "lm")
#strong positive relationship. 

ggplot(df_nonTOT_clean, aes(x = Age, y = WinP_Tm)) +
  geom_point(alpha = 0.5, colour = "dodgerblue") +
  geom_smooth(method = "lm")

ggplot(df_nonTOT_clean, aes(x = PTS_per_MP, y = WinP_Tm)) +
  geom_point(alpha = 0.5, colour = "darkgreen") +
  geom_smooth(method = "lm")

ggplot(df_nonTOT_clean, aes(x = EFF, y = PTS_per_MP)) +
  geom_point(alpha = 0.5, colour = "dodgerblue") +
  geom_smooth(method = "lm")


## Pairs plot for visualizing relationship between > 2 variables

pairs(formula = ~ PTS_per_MP + eFGp + TRB_MP + Tm_use_total + EFF + TrV, data = df_nonTOT_clean)

## HOw many more W when controlling for other factors

lm_bb_hr <- lm(PTS_per_MP ~  eFGp + TRB_MP + Tm_use_total + EFF + TrV, data = df_nonTOT_clean)
tidy(lm_bb_hr, conf.int = TRUE)

#tidy(lm_bb_hr, conf.int = TRUE)
# A tibble: 6 x 7
#term            estimate  std.error statistic   p.value    conf.low  conf.high
#<chr>              <dbl>      <dbl>     <dbl>     <dbl>       <dbl>      <dbl>
#  1 (Intercept)  -0.382      0.0181       -21.1   1.68e- 60 -0.418      -0.347    
#2 eFGp          0.699      0.0315        22.2   2.73e- 64  0.637       0.761    
#3 TRB_MP       -0.0330     0.0175        -1.88  6.04e-  2 -0.0674      0.00146  
#4 Tm_use_total  2.39       0.0367        65.0   3.24e-174  2.31        2.46     
#5 EFF           0.00000965 0.00000429     2.25  2.53e-  2  0.00000120  0.0000181
#6 TrV          -0.00000803 0.0000104     -0.774 4.40e-  1 -0.0000284   0.0000124



## for every 1 increase of eFGp, PTS_per_MP will increase by .699

fit <- lm(PTS_per_MP ~ eFGp + TRB_MP + Tm_use_total + EFF + TrV,
          data = df_nonTOT_clean)
tidy(fit, conf.int = TRUE)


### Predicted value formula important to remember

#> tidy(fit, conf.int = TRUE)
# A tibble: 6 x 7
#term            estimate  std.error statistic   p.value    conf.low  conf.high
#<chr>              <dbl>      <dbl>     <dbl>     <dbl>       <dbl>      <dbl>
#1 (Intercept)  -0.382      0.0181       -21.1   1.68e- 60 -0.418      -0.347    
#2 eFGp          0.699      0.0315        22.2   2.73e- 64  0.637       0.761    
#3 TRB_MP       -0.0330     0.0175        -1.88  6.04e-  2 -0.0674      0.00146  
#4 Tm_use_total  2.39       0.0367        65.0   3.24e-174  2.31        2.46     
#5 EFF           0.00000965 0.00000429     2.25  2.53e-  2  0.00000120  0.0000181
#6 TrV          -0.00000803 0.0000104     -0.774 4.40e-  1 -0.0000284   0.0000124

# as such if 
#eFG = 0.55
#TRB_MP = .2
#Tm_use_total = 0.2
#EFF = 1500
#TrV = 600
#Predictive formula to PTS_per_MP
-0.382 + 0.699 * 0.55 + -0.0330 * 0.2 + 2.39 * 0.20 + 0.00000965 * 1500 + -0.00000803 * 600
## [1] 0.483507


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

#> car::avPlots(fit)
#> car::vif(fit)
####eFGp       TRB_MP Tm_use_total          EFF          TrV 
###1.428056     1.265889     2.282248     3.430486     1.844460 
#> sqrt(car::vif(fit))
###eFGp       TRB_MP Tm_use_total          EFF          TrV 
##1.195013     1.125117     1.510711     1.852157     1.358109 

## can use model to then fit into model.

model_testing <- df_nonTOT_clean[c(1:20)]

summary(PGmodel_testing)
### New df creation
model_testing <- mutate(model_testing, exp_PTS_per_MP = predict(fit, newdata = model_testing))

## move exp_PTS_per_MP
model_testing <- model_testing %>%
  relocate(exp_PTS_per_MP, .after = WinP_Tm)

## model testing
ggplot(model_testing, aes(exp_PTS_per_MP, PTS_per_MP, label = "", colour = Pos)) +
  geom_point(alpha = 0.5) +
  geom_text(nudge_x = 0.105, cex = 3) +
  geom_abline(linetype = "dashed", colour = "magenta")

## dashed line is if everything was predicted correctly, would line up on line
# points above the line - under estimated, below the line = over estimated


## create Team average of exp_PTS_per MP
model_Tm_test <- model_testing %>%
  group_by(Tm) %>%
  summarise(Tm_exp_Pts_per_MP = mean(exp_PTS_per_MP),
                Tm_Pts_per_MP = mean(PTS_per_MP)) %>%
  ungroup()


## ungroup(model_Tm_test <- model_Tm_test
## join model_Tm_test and model_testing %>%
model_testing  <- model_Tm_test %>%
  select("Tm", "Tm_exp_Pts_per_MP", "Tm_Pts_per_MP") %>%
  right_join(model_testing, by = "Tm")

# Looking at correlation of WinP_Tm to Tm_exp_Pts_per_MP

ggplot(model_testing, aes(x = Tm_exp_Pts_per_MP, y = WinP_Tm, label = Tm)) +
  geom_point(colour = "dodgerblue") +
  geom_text(nudge_x = .00002, nudge_y = 1, cex = 3)

ggplot(model_testing, aes(x = Tm_Pts_per_MP, y = WinP_Tm, label = Tm)) +
  geom_point(colour = "red") +
  geom_text(nudge_x = .00002, nudge_y = 1, cex = 3)

## model testing plot trial
model_testingTM_plot <- model_testing %>%
  select("Tm", "Tm_Pts_per_MP", "WinP_Tm")

ggplot(model_testing, aes(x = Tm_exp_Pts_per_MP, y = WinP_Tm, label = Tm)) +
  geom_point(alpha = 0.3) +
  geom_point(data = model_testingTM_plot, aes(x = Tm_Pts_per_MP, y = WinP_Tm, colour = "", fill = "")) +
  geom_text(nudge_x = .00002, nudge_y = 1, cex = 3) +
  labs(title = "Team Win Percentage vs Expected points/minute", 
     subtitle = "Teams have increased winning % with an increased pts/min", 
     caption = "Data sourced from the fNBA stats package....",
     colour = "Actual pts/min",
     fill = "Expected pts/min") +
  xlab("Pts per minute (Expected/Actual)") +
  ylab("Win Percentage") +
  scale_colour_manual(values = c("hotpink")) +
  theme_light()
  

## model testing with Tm_exp_Pts_per_MP and Tm_Pts_per_MP
ggplot(model_testing, aes(Tm_exp_Pts_per_MP, Tm_Pts_per_MP, label = Tm, colour = Tm)) +
  geom_point(alpha = 0.5) +
  geom_text(nudge_x = 0.005, cex = 3) +
  geom_abline(linetype = "dashed", colour = "magenta")
  
## now to assess data frame
model_testing %>% 
  select(player_name, Tm, Age, Pos, salary, TrV, EFF, Tm_use_total,PTS_per_MP, TRB_MP, exp_PTS_per_MP) %>% 
  arrange(desc(exp_PTS_per_MP), salary) %>%
  top_n(20)


## Plotly scatter plot with salary

### Interactive graphs
library(plotly)
## create scatterplot first and save to the object gg2

gg2 <- ggplot(data = model_testing, aes(x = Tm_exp_Pts_per_MP, y = WinP_Tm, label = Tm, group = 1,
                                        text = paste("Team: =", Tm,
                                                     "<br>Win%: ", round(WinP_Tm, digits = 4),
                                                     "<br>Actual Points: ", round(Tm_Pts_per_MP, digits = 4),"Pts/min",
                                                     "<br>Expected Points: ", round(Tm_exp_Pts_per_MP, digits = 4), "Pts/min")
        )) +
  geom_point(colour = "black", aes(Tm_Pts_per_MP, WinP_Tm)) +
  geom_point(colour = "hotpink") +
  geom_text(nudge_x = .00002, nudge_y = 1, cex = 3) +
  labs(title = "Team Win Percentage vs Expected points/minute", 
       subtitle = "Teams with increased pts/min have a higher winning % ", 
       caption = "Data sourced from the NBA stats packages, see reference list",
       colour = "Actual pts/min",
       fill = "Expected pts/min") +
  xlab("Pts per minute (Expected/Actual)") +
  ylab("Win Percentage") +
  theme_light()

ggplotly(gg2, tooltip = "text") %>% 
  config(displayModeBar = "static", displaylogo = FALSE, 
         modeBarButtonsToRemove = list("sendDataToCloud", "toImage", "autoScale2d", "resetScale2d", 
                                       "hoverClosestCartesian", "hoverCompareCartesian", "select2d", 
                                       "lasso2d", "zoomIn2d", "zoomOut2d", "toggleSpikelines"))

gg2 +
  guides(colour = guide_legend("Points per/min"),
         fill = guide_legend("Points per/min"))


## Salary and player finder

gg <- ggplot(data = model_testing, aes(x = salary/1000000, y = exp_PTS_per_MP, color = Pos, label = Tm, group = 1,
                                       text = paste("Name:", player_name,
                                                    "<br>Team: =", Tm,
                                                    "<br>Salary: ", salary,
                                                    "<br>Trade Value: ", TrV,
                                                    "<br>Efficiency: ", EFF,
                                                    "<br>Expected Points: ", round(Tm_exp_Pts_per_MP, digits = 4), "Pts/min",
                                                    "<br>Team Usage %:", Tm_use_total,
                                                    "<br>Total Rebounds/min:", TRB_MP))) + 
  labs(title = "Player Salary vs Expected points/minute", 
       subtitle = "Teams have increased winning % with an increased pts/min", 
       caption = "Data sourced from the fNBA stats package....",
       colour = "Position") +
  geom_point() +
  xlab("Salary (Millions)") +
  ylab("Expected Points/min")

ggplotly(gg, tooltip = "text") %>% 
  config(displayModeBar = "static", displaylogo = FALSE, 
         modeBarButtonsToRemove = list("sendDataToCloud", "toImage", "autoScale2d", "resetScale2d", 
                                       "hoverClosestCartesian", "hoverCompareCartesian", "select2d", 
                                       "lasso2d", "zoomIn2d", "zoomOut2d", "toggleSpikelines"))



gg3 <- ggplot(data = model_testing, aes(x = salary/1000000, y = TrV, color = Pos, label = Tm, group = 1,
                                        text = paste("Name:", player_name,
                                                     "<br>Team: =", Tm,
                                                     "<br>Salary: ", salary,
                                                     "<br>Trade Value: ", TrV,
                                                     "<br>Efficiency: ", EFF,
                                                     "<br>Expected Points: ", round(Tm_exp_Pts_per_MP, digits = 4), "Pts/min",
                                                     "<br>Team Usage %:", Tm_use_total,
                                                     "<br>Total Rebounds/min:", TRB_MP))) + 
  labs(title = "Player Trade Value vs Player Salary", 
       subtitle = "Teams have increased winning % with an increased pts/min", 
       caption = "Data sourced from the fNBA stats package....",
       colour = "Position") +
  geom_point() +
  xlab("Salary (Millions)") +
  ylab("Trade Value")

ggplotly(gg, tooltip = "text") %>% 
  config(displayModeBar = "static", displaylogo = FALSE, 
         modeBarButtonsToRemove = list("sendDataToCloud", "toImage", "autoScale2d", "resetScale2d", 
                                       "hoverClosestCartesian", "hoverCompareCartesian", "select2d", 
                                       "lasso2d", "zoomIn2d", "zoomOut2d", "toggleSpikelines"))


gg4 <- ggplot(data = model_testing, aes(x = salary/1000000, y = EFF, color = Pos, label = Tm, group = 1,
                                        text = paste("Name:", player_name,
                                                     "<br>Team: =", Tm,
                                                     "<br>Salary: ", salary,
                                                     "<br>Trade Value: ", TrV,
                                                     "<br>Efficiency: ", EFF,
                                                     "<br>Expected Points: ", round(Tm_exp_Pts_per_MP, digits = 4), "Pts/min",
                                                     "<br>Team Usage %:", Tm_use_total,
                                                     "<br>Total Rebounds/min:", TRB_MP))) + 
  labs(title = "Player Efficiency Rating vs Player Salary", 
       subtitle = "Teams have increased winning % with an increased pts/min", 
       caption = "Data sourced from the fNBA stats package....",
       colour = "Position") +
  geom_point() +
  xlab("Salary (Millions)") +
  ylab("Expected Points/min")

ggplotly(gg, tooltip = "text") %>% 
  config(displayModeBar = "static", displaylogo = FALSE, 
         modeBarButtonsToRemove = list("sendDataToCloud", "toImage", "autoScale2d", "resetScale2d", 
                                       "hoverClosestCartesian", "hoverCompareCartesian", "select2d", 
                                       "lasso2d", "zoomIn2d", "zoomOut2d", "toggleSpikelines"))
