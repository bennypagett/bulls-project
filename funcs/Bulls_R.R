##chicago Bulls Project
library(tidyverse)
library(readr)
library(dplyr)
library(broom)
library(performance)
library(psych)

#18-19 Player salaries
df1819Sal <- read_csv("data/project_data/2018-19_nba_player-salaries.csv")
View(df1819Sal)

## 18-19Player Stats
df1819Stats <- read_csv("data/project_data/2018-19_nba_player-statistics.csv")
View(df1819Stats)

## 18-19 Stats 1
df1819Stats1 <- read_csv("data/project_data/2018-19_nba_team-statistics_1.csv")
View(df1819Stats1)

## 18-19 Stats 2
df1819Stats2 <- read_csv("data/project_data/2018-19_nba_team-statistics_2.csv")
View(df1819Stats2)

## 2019-20 Pay roll team
df1920Pay <- read_csv("data/project_data/2019-20_nba_team-payroll.csv")
View(df1920Pay)

view(df1819Stats)


###dealing with missing values and converting NA's to 0

sum(is.na(df1819Stats))
which(is.na(df1819Stats), arr.ind = TRUE)
df1819Stats <- replace_na(df1819Stats, list("FG%" = 0,
                                            "3P%" = 0,
                                            "2P%" = 0,
                                            "eFG%" = 0,
                                            "FT%" = 0))
sum(is.na(df1819Stats))

sum(is.na(df1819Stats1))
which(is.na(df1819Stats1), arr.ind = TRUE)
df1819Stats1 <- replace_na(df1819Stats1, list("X23" = 0,
                                            "X24" = 0,
                                            "X25" = 0))

sum(is.na(df1819Stats1))

sum(is.na(df1819Stats2))
which(is.na(df1819Stats2), arr.ind = TRUE)




##working script on combining data sets
df1819Stats <- df1819Sal(select = player_id, player_name, salary) %>%
              right_join(df1819Stats, by= "player_name")
              
df1819Stats <- df1819Sal %>%
  select(player_name, salary, player_id) %>%
  right_join(df1819Stats, by="player_name")

## combine data sets using full join to retain everything 
data_full <- full_join(x = df1819Stats, y = df1819Sal,
                       by = c("player_name"))
view(data_full)

duplicated(data_full)
rbind(data_full$player_name)

###########################
library(dplyr)
newdf <- data_full %>% 
  group_by(player_id) %>% 
  summarise_each(funs(mean))

view(newdf)

####now have everything together and rows combined with averages for each value
###then mutuate ie create new variables dividing the averages by mins played?
##### get rid of columns with na vals before merging them back in per player_ID

newdf2 <- newdf[-c(2,3,5)]

view(newdf2)
###now have new df to then join the player name and positions and TM to by player id

newdf2 <- data_full(select = "player_name", "Pos", "Tm") %>%
  right_join(data_full, by= "player_name")

view(data_full)

newdf2 <- data_full %>%
  select(player_name + Pos + Tm) %>%
  right_join(newdf2, by="player_id")

newdf2 %>% 
  (select = player_name + Pos + Tm)
  inner_join(data_full, by = "player_id")

#remove duplicates
library(dplyr)
newdf <- data_full %>%
  group_by(player_id) %>%
  aggregate(data_full[,5:31], list(data_full$player_id), mean)

newdf <- data_full %>%
  group_by(player_id) %>%
  aggregate(data_full[,5:31], mean)

aggregate(y~x,data=data_full,FUN=sum)

library(plyr)
ddply(data_full,"player_id",numcolwise(sum))

library(dplyr)
data_full %>% 
  group_by(player_id) %>% 
  summarise(y = sum(5:31))

view(newdf)

newdf <- aggregate(df1819Stats[,5:29], list(df1819Stats$player_name), sum)


##### code for mutating variables to use in model
##normalise averages in newdf2 by MP

newdf2 <- 
  mutate(GS_per_MP = GS / MP,
         FG_per_MP = FG / MP,
         FGA_per_MP = FGA / MP,
         3P_per_MP = 3P / MP,
         3PA_per_MP = 3PA / MP,
         2P_per_MP = 2PA / MP,
         FT_per_MP = FT / MP,
         FTA_per_MP = FTA / MP,
         ORB_per_MP = ORB / MP,
         DRB_per_MP = DRB / MP,
         TRB_per_MP = TRB / MP,
         AST_per_MP = AST / MP,
         STL_per_MP = STL / MP,
         BLK_per_MP = BLK / MP,
         TOV_per_MP = TOV / MP,
         PF_per_MP = PF / MP,
         PTS_per_MP = PTS / MP)
