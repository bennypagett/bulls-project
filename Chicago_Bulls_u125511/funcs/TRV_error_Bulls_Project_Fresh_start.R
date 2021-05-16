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
library(tibble)
library(vctrs)

## Reading in data
## 18-19 Player salaries
dfsal <- read_csv("data/project-data/2018-19_nba_player-salaries.csv")
## 18-19Player Stats
df_ind_stats <- read_csv("data/project-data/2018-19_nba_player-statistics.csv")
## 18-19 Stats 1
df_team_Stats1 <- read_csv("data/project-data/2018-19_nba_team-statistics_1.csv")
## 18-19 Stats 2
df_team_Stats2 <- read_csv("data/project-data/2018-19_nba_team-statistics_2.csv")
## 2019-20 Pay roll team
dfPay <- read_csv("data/project-data/2019-20_nba_team-payroll.csv")


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


## NA values Team stats 2
sum(is.na(df_team_Stats2))
which(is.na(df_team_Stats2), arr.ind = TRUE)


## dealing with spelling and abbreviated name, change to e.g. Patrick Mills as per salary file
df_ind_stats[df_ind_stats$player_name=="Patty Mills", "player_name"] <- "Patrick Mills"

df_ind_stats[df_ind_stats$player_name=="Ray Spalding", "player_name"] <- "Raymond Spalding"

df_ind_stats[df_ind_stats$player_name=="Cameron Reynolds", "player_name"] <- "Cam Reynolds"

df_ind_stats[df_ind_stats$player_name=="Dennis Schroder", "player_name"] <- "Dennis Schroeder"

df_ind_stats[df_ind_stats$player_name=="Ish Smith", "player_name"] <- "Ishmael Smith"

df_ind_stats[df_ind_stats$player_name=="Taurean Waller-Prince", "player_name"] <- "Taurean Prince"

df_ind_stats[df_ind_stats$player_name=="Lou Williams", "player_name"] <- "Louis Williams"

df_ind_stats[df_ind_stats$player_name=="Jakob Poltl", "player_name"] <- "Jakob Poeltl"

df_ind_stats[df_ind_stats$player_name=="Naz Mitrou-Long", "player_name"] <- "Naz Long"

df_ind_stats[df_ind_stats$player_name=="Luc Mbah a Moute", "player_name"] <- "Luc Mbah"

df_ind_stats[df_ind_stats$player_name=="Timothe Luwawu-Cabarrot", "player_name"] <- "Timothe Luwawu"

df_ind_stats[df_ind_stats$player_name=="Walt Lemon", "player_name"] <- "Walter Lemon"

df_ind_stats[df_ind_stats$player_name=="Nene Hilario", "player_name"] <- "Nene"

df_ind_stats[df_ind_stats$player_name=="Maurice Harkless", "player_name"] <- "Moe Harkless"

df_ind_stats[df_ind_stats$player_name=="Devonte' Graham", "player_name"] <- "Devonte Graham"

df_ind_stats[df_ind_stats$player_name=="Vince Edwards", "player_name"] <- "Vincent Edwards"

df_ind_stats[df_ind_stats$player_name=="DeAndre' Bembry", "player_name"] <- "DeAndre Bembry"

df_ind_stats[df_ind_stats$player_name=="JJ Barea", "player_name"] <- "Jose Juan"

df_ind_stats[df_ind_stats$player_name=="Mitch Creek", "player_name"] <- "Mitch Creek"
view(df_ind_stats)


#### Prep for Usage ratio: 
## rename team stats with T_var in Stats2
  df_team_Stats2[df_team_Stats2$Team == "Milwaukee Bucks", "Team"] <- "MIL"
  df_team_Stats2[df_team_Stats2$Team == "Golden State Warriors", "Team"] <- "GSW"
  df_team_Stats2[df_team_Stats2$Team == "Philadelphia 76ers", "Team"] <- "PHI"
  df_team_Stats2[df_team_Stats2$Team == "Los Angeles Clippers", "Team"] <- "LAC"
  df_team_Stats2[df_team_Stats2$Team == "Portland Trail Blazers", "Team"] <-"POR"
  df_team_Stats2[df_team_Stats2$Team == "Oklahoma City Thunder", "Team"] <- "OKC"
  df_team_Stats2[df_team_Stats2$Team == "Toronto Raptors", "Team"] <-"TOR"
  df_team_Stats2[df_team_Stats2$Team == "Sacramento Kings", "Team"] <- "SAC"
  df_team_Stats2[df_team_Stats2$Team == "Washington Wizards", "Team"] <- "WAS"
  df_team_Stats2[df_team_Stats2$Team == "Houston Rockets", "Team"] <- "HOU"
  df_team_Stats2[df_team_Stats2$Team == "Atlanta Hawks", "Team"] <- "ATL"
  df_team_Stats2[df_team_Stats2$Team == "Minnesota Timberwolves", "Team"] <-"MIN"
  df_team_Stats2[df_team_Stats2$Team == "Boston Celtics", "Team"] <- "BOS"
  df_team_Stats2[df_team_Stats2$Team == "Brooklyn Nets", "Team"] <- "BRK"
  df_team_Stats2[df_team_Stats2$Team == "Los Angeles Lakers", "Team"] <- "LAL"
  df_team_Stats2[df_team_Stats2$Team == "Utah Jazz", "Team"] <- "UTA"
  df_team_Stats2[df_team_Stats2$Team == "San Antonio Spurs", "Team"] <- "SAS"
  df_team_Stats2[df_team_Stats2$Team == "Charlotte Hornets", "Team"] <- "CHO"
  df_team_Stats2[df_team_Stats2$Team == "Denver Nuggets", "Team"] <- "DEN"
  df_team_Stats2[df_team_Stats2$Team == "Dallas Mavericks", "Team"] <- "DAL"
  df_team_Stats2[df_team_Stats2$Team == "Indiana Pacers", "Team"] <-  "IND"
  df_team_Stats2[df_team_Stats2$Team == "Phoenix Suns", "Team"] <- "PHO"
  df_team_Stats2[df_team_Stats2$Team == "Orlando Magic", "Team"] <- "ORL"
  df_team_Stats2[df_team_Stats2$Team == "Detroit Pistons", "Team"] <- "DET"
  df_team_Stats2[df_team_Stats2$Team == "Miami Heat", "Team"] <- "MIA"
  df_team_Stats2[df_team_Stats2$Team == "Chicago Bulls", "Team"] <- "CHI"
  df_team_Stats2[df_team_Stats2$Team == "New York Knicks", "Team"] <- "NYK"
  df_team_Stats2[df_team_Stats2$Team == "Cleveland Cavaliers", "Team"] <- "CLE"
  df_team_Stats2[df_team_Stats2$Team == "Memphis Grizzlies", "Team"] <- "MEM"
  df_team_Stats2[df_team_Stats2$Team == "New Orleans Pelicans", "Team"] <- "NOP"
view(df_team_Stats2)

## change col name Team -> Tm
names(df_team_Stats2)[2] <- "Tm"
names(df_team_Stats2)[4] <- "Tm_MP"
names(df_team_Stats2)[6] <- "Tm_FGA"
names(df_team_Stats2)[15] <- "Tm_FTA"
names(df_team_Stats2)[23] <- "Tm_TOV"
names(df_team_Stats2)[3] <- "Tm_G"

## rename team stats with T_var in Stats2
df_team_Stats1[df_team_Stats1$Team == "Milwaukee Bucks", "Team"] <- "MIL"
df_team_Stats1[df_team_Stats1$Team == "Golden State Warriors", "Team"] <- "GSW"
df_team_Stats1[df_team_Stats1$Team == "Philadelphia 76ers", "Team"] <- "PHI"
df_team_Stats1[df_team_Stats1$Team == "Los Angeles Clippers", "Team"] <- "LAC"
df_team_Stats1[df_team_Stats1$Team == "Portland Trail Blazers", "Team"] <-"POR"
df_team_Stats1[df_team_Stats1$Team == "Oklahoma City Thunder", "Team"] <- "OKC"
df_team_Stats1[df_team_Stats1$Team == "Toronto Raptors", "Team"] <-"TOR"
df_team_Stats1[df_team_Stats1$Team == "Sacramento Kings", "Team"] <- "SAC"
df_team_Stats1[df_team_Stats1$Team == "Washington Wizards", "Team"] <- "WAS"
df_team_Stats1[df_team_Stats1$Team == "Houston Rockets", "Team"] <- "HOU"
df_team_Stats1[df_team_Stats1$Team == "Atlanta Hawks", "Team"] <- "ATL"
df_team_Stats1[df_team_Stats1$Team == "Minnesota Timberwolves", "Team"] <-"MIN"
df_team_Stats1[df_team_Stats1$Team == "Boston Celtics", "Team"] <- "BOS"
df_team_Stats1[df_team_Stats1$Team == "Brooklyn Nets", "Team"] <- "BRK"
df_team_Stats1[df_team_Stats1$Team == "Los Angeles Lakers", "Team"] <- "LAL"
df_team_Stats1[df_team_Stats1$Team == "Utah Jazz", "Team"] <- "UTA"
df_team_Stats1[df_team_Stats1$Team == "San Antonio Spurs", "Team"] <- "SAS"
df_team_Stats1[df_team_Stats1$Team == "Charlotte Hornets", "Team"] <- "CHO"
df_team_Stats1[df_team_Stats1$Team == "Denver Nuggets", "Team"] <- "DEN"
df_team_Stats1[df_team_Stats1$Team == "Dallas Mavericks", "Team"] <- "DAL"
df_team_Stats1[df_team_Stats1$Team == "Indiana Pacers", "Team"] <-  "IND"
df_team_Stats1[df_team_Stats1$Team == "Phoenix Suns", "Team"] <- "PHO"
df_team_Stats1[df_team_Stats1$Team == "Orlando Magic", "Team"] <- "ORL"
df_team_Stats1[df_team_Stats1$Team == "Detroit Pistons", "Team"] <- "DET"
df_team_Stats1[df_team_Stats1$Team == "Miami Heat", "Team"] <- "MIA"
df_team_Stats1[df_team_Stats1$Team == "Chicago Bulls", "Team"] <- "CHI"
df_team_Stats1[df_team_Stats1$Team == "New York Knicks", "Team"] <- "NYK"
df_team_Stats1[df_team_Stats1$Team == "Cleveland Cavaliers", "Team"] <- "CLE"
df_team_Stats1[df_team_Stats1$Team == "Memphis Grizzlies", "Team"] <- "MEM"
df_team_Stats1[df_team_Stats1$Team == "New Orleans Pelicans", "Team"] <- "NOP"
view(df_team_Stats1)

##Create right join for further joining below
##Create right join from Stats 1 W and L, 
##Right join Stats1 W, L, and create W and Tm_L
## Change team variable name
names(df_team_Stats1)[2] <- "Tm"

df_ind_stats <- df_team_Stats1 %>%
  select(Tm, W, L) %>%
  right_join(df_ind_stats, by="Tm")

## Right join Tm data to facilitate Usage analysis
df_ind_stats <- df_team_Stats2 %>%
  select(Tm, Tm_MP, Tm_FGA, Tm_FTA, Tm_TOV, Tm_G) %>%
  right_join(df_ind_stats, by="Tm")

view(df_ind_stats)

## Filter/remove players TOT teams, as summary of stats done later
df_TOT_players <- df_ind_stats[(df_ind_stats$Tm == "TOT"),]

df_ind_stats <- df_ind_stats[!(df_ind_stats$Tm == "TOT"),]

sum(is.na(df_ind_stats))
which(is.na(df_ind_stats), arr.ind = TRUE)

duplicated(df_ind_stats$player_name)
which(duplicated(df_ind_stats$player_name), arr.ind = TRUE)

df_ind_stats_no_doubles <- df_ind_stats[!duplicated(df_ind_stats$player_name),]

## Join df_ind_stats and dfsal
## Join Salary and Stats

df_joined <- full_join(x = df_ind_stats, y = dfsal,
                       by = c("player_name"))
view(df_joined)

sum(is.na(df_joined))
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

view(df_joined)

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
df_joined <- df_joined %>%
  relocate(player_id, .before = player_name)
df_joined <- df_joined %>%
  relocate(Tm, .before = salary)
df_joined <- df_joined %>%
  relocate(Tm_MP, .after = PTS)
df_joined <- df_joined %>%
  relocate(Tm_FGA, .after = Tm_MP)
df_joined <- df_joined %>%
  relocate(Tm_FTA, .after = Tm_FGA)
df_joined <- df_joined %>%
    relocate(Tm_TOV, .after = Tm_FTA)
df_joined <- df_joined %>%
    relocate(Tm_G, .after = PTS)
view(df_joined)

## Duplicates
duplicated(df_joined$player_name)
sum(duplicated(df_joined$player_name))
which(duplicated(df_joined$player_name), arr.ind = TRUE)

 
## rename df_joined Tidy coloumn = 3P, 2P, 3PA, 2PA
names(df_joined)[15] <- "X3P"
names(df_joined)[16] <- "X3PA"
names(df_joined)[18] <- "X2P"
names(df_joined)[19] <- "X2PA"

view(df_joined)

str(df_joined)

## Usage100 * ((FGA + 0.44 * FTA + TOV) * (Tm MP / 5)) / (MP * (Tm FGA + 0.44 * Tm FTA + Tm TOV))

df_joined <- df_joined %>%
  mutate(Tm_use = ((df_joined$FGA + 0.44 * df_joined$FTA + df_joined$TOV) * (df_joined$Tm_MP / 5)) / ((df_joined$MP * (df_joined$Tm_FGA + 0.44 * df_joined$Tm_FTA + df_joined$Tm_TOV))),)

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
            FG_MP = (sum(FG)/ MP),
            FGA_MP = (sum(FGA)/ MP),
            FGp_MP = ((FG/FGA)/ MP),
            X3P_MP = (sum(X3P)/ MP),
            X3PA_MP = (sum(X3PA)/ MP),
            X3Pp_MP = ((X3P/X3PA)/ MP),
            X2P_MP = (sum(X2P)/ MP),
            X2PA_MP = (sum(X2PA)/ MP),
            X2Pp_MP = ((X2P/X2PA)/ MP),
            FT_MP = (sum(FT)/ MP),
            FTA_MP = (sum(FTA)/ MP),
            FTp_MP = ((FT/FTA)/ MP),
            ORB_MP = (sum(ORB)/ MP),
            DRB_MP = (sum(DRB)/ MP),
            TRB_MP = (sum(TRB)/ MP),
            AST_MP = (sum(AST)/ MP),
            STL_MP = (sum(STL)/ MP),
            BLK_MP = (sum(BLK)/ MP),
            TOV_MP = (sum(TOV)/ MP),
            PF_MP = (sum(PF)/ MP),
            PTS_per_MP = (sum(PTS)/ MP),
            FTF_MP = (FTA/FGA) / MP,
            Tm_use_total = sum(Tm_use))
            
view(df_clean)  

ungroup(df_clean)


### Creation of other analysis variables EFF

df_clean <- df_clean %>%
  mutate(EFF = PTS + TRB + AST + STL + BLK - (FGA-FG) - (FTA-FT) -TOV / G)
df_clean

view(df_clean)

## eFG stat

df_clean <- df_clean %>%
  mutate(eFGp = (X2P + (1.5*X3P))/ FGA)

view(df_clean)

## Trade Value Formula & Aprox Value & Credits
# Credits Formula = Creds
df_clean <- df_clean %>%
  mutate(Creds = (PTS)+(TRB)+(AST)+(STL)+(BLK)-(FGA - FG) - (FTA - FT) - (TOV))

## Approximate value  = ApproxV
df_clean <- df_clean %>%
  mutate(ApproxV = (Creds^(3/4))/21)

# Trade Value
df_clean <- df_clean %>%
  mutate(TradeV = ((df_clean$ApproxV - 27 - 0.75 * df_clean$Age)^2*(27 - 0.75 * df_clean$Age + 1) * df_clean$ApproxV) / 190 + (df_clean$ApproxV) * 2 /13,  size = 531, replace = TRUE)

vec_size(df_clean)

### round to 4 digits

df_clean <- df_clean %>%
  mutate(across(c(11:61), round, 4))

view(df_clean)

sum(is.na(df_clean))

### replace NA's

df_clean[is.na(df_clean)] = 0

## merge

df_clean  <- df_joined %>%
  select(player_name, player_id, salary, Age, Tm_G, Tm_MP, Tm_FGA, Tm_FTA, Tm_TOV) %>%
  right_join(df_clean, by = "player_id")
df_clean  

df_clean <- df_clean %>%
  relocate(Tm_FGA, .after = PTS_per_game)
df_clean <- df_clean %>%
  relocate(Tm_MP, .after = Tm_FGA)
df_clean <- df_clean %>%
  relocate(Tm_FTA, .after = Tm_MP)
df_clean <- df_clean %>%
  relocate(Tm_G, .after = Tm_FTA)
df_clean <- df_clean %>%
  relocate(Tm_TOV, .after = Tm_G)

  
##fix merged names player_name
df_clean <- df_clean[-c(1,3,4)]

names(df_clean)[2] <- "salary"
names(df_clean)[3] <- "player_name"
names(df_clean)[4] <- "Age"

df_clean <- df_clean %>%
  relocate(eFGp, .after = MP)
df_clean <- df_clean %>%
  relocate(TrV, .after = MP)
df_clean <- df_clean %>%
  relocate(EFF, .after = TrV)
df_clean <- df_clean %>%
  relocate(Tm_use_total, .after = EFF)

## final double check and clean.
ungroup(df_clean)
duplicated(df_clean$player_name)
which(duplicated(df_clean$player_name), arr.ind = TRUE)

df_clean_no_doubles <- df_clean[!duplicated(df_clean$player_name),]

duplicated(df_clean_no_doubles$player_name)
which(duplicated(df_clean_no_doubles$player_name), arr.ind = TRUE)

write_csv(df_clean_no_doubles, file = "data/tidy_data/player_stats_tidy.csv")


df_new_TOT_joined <- full_join(x = df_TOT_players_Tm_W, y = player_stats_tidy,
                               by = c("player_name", "Age"))
view(df_new_TOT_joined)



sum(is.na(df_new_TOT_joined))

## remove retired/stood down players


df_new_TOT_joined<- df_new_TOT_joined %>%
  select(-c(1:7,8:35))


df_new_TOT_joined <- replace_na(df_new_TOT_joined, list(TOT = "TOT")
                                
                                
                                df_new_TOT_joined[is.na(df_new_TOT_joined)] = "nonTOT"
                                
                                df_new_TOT_joined <- df_new_TOT_joined %>%  # or add in whatever your data objects are that you want to round, and what you want to save to
                                  mutate(across(c(1:7,8:35), ~replace_na(.x, "nonTOT")))
                                
                                
                                
                                
                                
                                player_stats_tidy <- player_stats_tidy %>%
                                  mutate(TOT = "")
                                player_stats_tidy <- player_stats_tidy %>%
                                  relocate(TOT, .after = Tm)
                                
                                player_stats_tidy %>% mutate(TOT = case_when(a == 2 | a == 5 | a == 7 | (a == 1 & b == 4) ~ 2,
                                                                             a == 0 | a == 1 | a == 4 | a == 3 |  c == 4 ~ 3,
                                                                             TRUE ~ NA_real_))
                                
                                view()
                                ## duplicate    
                                
                                duplicated(df_new_TOT_joined$player_name)
                                which(duplicated(df_new_TOT_joined$player_name), arr.ind = TRUE)
                                
                                
                                
                                
