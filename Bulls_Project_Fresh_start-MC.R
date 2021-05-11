## Fresh start - Bulls Project

## Chicago Bulls - Player Assessment


library(tidyverse)
library(ggplot2)
library(readr)
library(dplyr)
library(broom)
library(performance)
library(psych)
library(ggrepel)

## Reading in data
## 18-19 Player salaries
dfsal <- read_csv("data/project_data/2018-19_nba_player-salaries.csv")
View(dfsal)

## 18-19Player Stats
df_ind_stats <- read_csv("data/project_data/2018-19_nba_player-statistics.csv")
View(df_ind_stats)

## 18-19 Stats 1
df_team_Stats1 <- read_csv("data/project_data/2018-19_nba_team-statistics_1.csv")
View(df_team_Stats1)

## 18-19 Stats 2
df_team_Stats2 <- read_csv("data/project_data/2018-19_nba_team-statistics_2.csv")
View(df_team_Stats2)

## 2019-20 Pay roll team
dfPay <- read_csv("data/project_data/2019-20_nba_team-payroll.csv")
View(dfPay)

##Structure and exploratory analysis

##Exploratory analysis 18-19 Stats
str(df_ind_stats)
head(df_ind_stats, 20)
tail(df_ind_stats, 20)

##Exploratory analysis 18-19 Sal
str(dfsal)
head(dfsal, 20)
tail(dfsal, 20)

##Exploratory analysis 18-19 Stats1
str(df1819Stats1)
head(df1819Stats1, 20)
tail(df1819Stats1, 20)

##Exploratory analysis 18-19 Stats2
str(df1819Stats2)
head(df1819Stats2, 20)
tail(df1819Stats2, 20)

##Exploratory analysis df1920Pay
str(df1920Pay)
head(df1920Pay, 20)
tail(df1920Pay, 20)


### replace NA with O Applicable to whole dataframe.
## NA df_ind-stats
sum(is.na(df_ind_stats))
which(is.na(df_ind_stats), arr.ind = TRUE)

##replace NA with "0" in df_ind_stats
df_ind_stats <- replace_na(df_ind_stats, list("FG%" = 0,
                                              "3P%" = 0,
                                              "2P%" = 0,
                                              "eFG%" = 0,
                                              "FT%" = 0))
sum(is.na(df_ind_stats))

## NA 1819Stats1
sum(is.na(df1819Stats1))
which(is.na(df1819Stats1), arr.ind = TRUE)

##replace NA with "0" in df1891Stats1
df_team_Stats1 <- replace_na(df_team_Stats1, list("X23" = 0,
                                              "X24" = 0,
                                              "X25" = 0))
sum(is.na(df_team_Stats1))


## dealing with Patty Mills abbreviated name, change to Patrick Mills as per salary file
df_ind_stats[df_ind_stats$player_name=="Patty Mills", "player_name"] <- "Patrick Mills"
view(df_ind_stats)

df_ind_stats[df_ind_stats$player_name=="Ray Spalding", "player_name"] <- "Raymond Spalding"
view(df_ind_stats)

df_ind_stats[df_ind_stats$player_name=="Cameron Reynolds", "player_name"] <- "Cam Reynolds"
view(df_ind_stats)

df_ind_stats[df_ind_stats$player_name=="Dennis Schroder", "player_name"] <- "Dennis Schroeder"
view(df_ind_stats)

df_ind_stats[df_ind_stats$player_name=="Ish Smith", "player_name"] <- "Ishmael Smith"
view(df_ind_stats)

df_ind_stats[df_ind_stats$player_name=="Taurean Waller-Prince", "player_name"] <- "Taurean Prince"
view(df_ind_stats)

df_ind_stats[df_ind_stats$player_name=="Lou Williams", "player_name"] <- "Louis Williams"
view(df_ind_stats)

df_ind_stats[df_ind_stats$player_name=="Jakob Poltl", "player_name"] <- "Jakob Poeltl"
view(df_ind_stats)

df_ind_stats[df_ind_stats$player_name=="Naz Mitrou-Long", "player_name"] <- "Naz Long"
view(df_ind_stats)

df_ind_stats[df_ind_stats$player_name=="Luc Mbah a Moute", "player_name"] <- "Luc Mbah"
view(df_ind_stats)

df_ind_stats[df_ind_stats$player_name=="Timothe Luwawu-Cabarrot", "player_name"] <- "Timothe Luwawu"
view(df_ind_stats)

df_ind_stats[df_ind_stats$player_name=="Walt Lemon", "player_name"] <- "Walter Lemon"
view(df_ind_stats)

df_ind_stats[df_ind_stats$player_name=="Nene Hilario", "player_name"] <- "Nene"
view(df_ind_stats)

df_ind_stats[df_ind_stats$player_name=="Maurice Harkless", "player_name"] <- "Moe Harkless"
view(df_ind_stats)

df_ind_stats[df_ind_stats$player_name=="Devonte' Graham", "player_name"] <- "Devonte Graham"
view(df_ind_stats)

df_ind_stats[df_ind_stats$player_name=="Vince Edwards", "player_name"] <- "Vincent Edwards"
view(df_ind_stats)

df_ind_stats[df_ind_stats$player_name=="DeAndre' Bembry", "player_name"] <- "DeAndre Bembry"
view(df_ind_stats)

df_ind_stats[df_ind_stats$player_name=="JJ Barea", "player_name"] <- "Jose Juan"
view(df_ind_stats)

df_ind_stats[df_ind_stats$player_name=="Mitch Creek", "player_name"] <- "Jose Juan"
view(df_ind_stats)

## Join df_ind_stats and dfsal
## Join Salary and Stats

df_joined <- full_join(x = df_ind_stats, y = dfsal,
                       by = c("player_name"))
view(df_joined)

sum(is.na(df_joined))
which(is.na(df_joined), arr.ind = TRUE)


sum(is.na(df_ind_stats))
which(is.na(df_joined), arr.ind = TRUE)

## NA in salary
df_joined %>%
  sum(is.na())
which(is.na(df_joined), arr.ind = TRUE)
filter(df_joined, is.na(df_joined$salary))

##replace salary NA with "Unknown"
df_joined <- replace_na(df_joined, list(salary = "unknown"))
sum(is.na(df_joined))

view(df_joined)

## player_id NA's
## NA
df_joined %>%
  sum(is.na())
which(is.na(df_joined), arr.ind = TRUE)
filter(df_joined, is.na(df_joined$player_id))

##replace NA with "unknown" to identify typos and retirements
df_joined <- replace_na(df_joined, list(player_id = "unknown"))
sum(is.na(df_joined$player_id))

view(df_joined)

### df_na to aid in typos and retirements

data_na <- df_joined %>%
  filter(df_joined$salary == "unknown")
data_na
view(data_na)

## Remove Mitchell Creek - double salary, but has data under Mitch Creek and Salary
## Retirements
## Need to remove Al Jefferson, Manu Ginobli etc - no playing data - retired.
##replace G NA with "Unknown"
df_joined <- replace_na(df_joined, list(G = "unknown"))
sum(is.na(df_joined))

view(df_joined)

df_joined %>%
  sum(is.na())
  which(is.na(df_joined), arr.ind = TRUE)
  filter(df_joined, is.na(df_joined$G))

data_na <- df_joined %>%
  filter(df_joined$G == "unknown")
data_na
view(data_na)

## Retired
df_joined <- replace_na(df_joined, list(GS = "RET"))
sum(is.na(df_joined))

view(df_joined)

## remove retired/stood down players
df_joined <- df_joined[!(df_joined$GS == "RET"),]

tail(df_joined)

## Change salary to numeric vector in df_joined
df_joined$salary <- as.numeric(df_joined$salary)
str(df_joined$salary)

## change salary to numeric dfsal
dfsal$salary <- as.numeric(dfsal$salary)
str(dfsal$salary)

## Change Pos to factor in df_joined
df_joined$Pos <- as.factor(df_joined$Pos)
str(df_joined$Pos)

## change G to numeric
df_joined$G <- as.numeric(df_joined$G)
str(df_joined$G)

## change GS to numeric
df_joined$GS <- as.numeric(df_joined$GS)
str(df_joined$GS)

## relocate salaries and POS and Age ## run df_joined first
df_joined <- df_joined %>%
  relocate(salary, .after = player_name)
view(df_joined)

df_joined <- df_joined %>%
  relocate(player_id, .before = player_name)
view(df_joined)

## Duplicates
duplicated(df_joined$player_name)
sum(duplicated(df_joined$player_name))
which(duplicated(df_joined$player_name), arr.ind = TRUE)

 
## rename df_joined Tidy coloumn = 3P, 2P, 3PA, 2PA
names(df_joined)[13] <- "X3P"
names(df_joined)[14] <- "X3PA"
names(df_joined)[16] <- "X2P"
names(df_joined)[17] <- "X2PA"

view(df_joined)

## summarise and fix duplicates
df_clean <- df_joined %>%
  group_by(player_id, player_name, Age) %>%
  summarise(Pos = paste(Pos, collapse = ", "),
            Tm = paste(Tm, collapse = ", "),
            G = sum(G),
            GS = sum(GS),
            MP = sum(MP),
            FG = sum(FG),
            FGA = sum(FGA),
            FGp = (FG/FGA),
            X3P = sum(X3P),
            X3PA = sum(X3PA),
            X3Pp = (X3P/X3PA),
            X2P = sum(X2P),
            X2PA = sum(X2PA),
            X2Pp = (X2P/X2PA),
            FT = sum(FT),
            FTA = sum(FTA),
            FTp = (FT/FTA),
            ORB = sum(ORB),
            DRB = sum(DRB),
            TRB = sum(TRB),
            AST = sum(AST),
            STL = sum(STL),
            BLK = sum(BLK),
            TOV = sum(TOV),
            PF = sum(PF),
            PTS = sum(PTS),
            FTF = (FTA/FGA),
            PTS_per_game = (PTS / G),
            PTS_per_min = (PTS / MP),
            ASTTOVR = (AST / TOV))
            
view(df_clean)  


## Variables at MP
## summarise and fix duplicates
df_MP_clean <- df_clean %>%
  group_by(player_id, player_name, Age) %>%
  summarise(digits = 3,
            Pos = Pos,
            Tm = Tm,
            G = G,
            GS = GS,
            MP = MP,
            FG = (FG / MP),
            FGA = (FGA / MP),
            FGp = (FG/FGA),
            X3P = (X3P/ MP),
            X3PA = (X3PA/ MP),
            X3Pp = (X3P/X3PA),
            X2P = (X2P/ MP),
            X2PA = (X2PA/ MP),
            X2Pp = (X2P/X2PA),
            FT = (FT/ MP),
            FTA = (FTA / MP),
            FTp = (FT/FTA),
            ORB = (ORB / MP),
            DRB = (DRB / MP),
            TRB = (TRB / MP),
            AST = (AST / MP),
            STL = (STL / MP),
            BLK = (BLK/ MP),
            TOV = (TOV / MP),
            PF = (PF / MP),
            PTS = (PTS / MP),
            FTF = (FTA/FGA),
            PTS_per_game = (PTS / G),
            PTS_per_min = (PTS / MP),
            ASTTOVR = (AST / TOV)/ MP)
            

view(df_MP_clean)

player_stats_tidy <- df_MP_clean

write_csv(player_stats_tidy, file = "data/tidy_data/player_stats_tidy.csv")

###rounding attempts
round_df_MP_clean(df_MP_clean, digits = 3)

library(dplyr)
df_MP_clean %>% 
  mutate_if(is.numeric, round, digits = 3)

df_MP_clean[,-1, -2, -3, -4, -5, -6, -7, -8, -9] <-round(df[,-1-2, -3, -4, -5, -6, -7, -8, -9],3) #the "-1" excludes column 1
df_MP_clean

df_MP_clean[,-1,9] <-round(df[,-1,9],3) 
df_MP_clean

round(df_MP_clean$PTS, digits = 3)

df_MP_clean <- df_MP_clean %>%
  summarise(df_MP_clean, digits=3)

 library(dplyr)           
df_MP_clean %>% mutate(select(where(is.numeric, ~ round(.,3))))

?where
