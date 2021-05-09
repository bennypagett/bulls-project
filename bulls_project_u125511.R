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
dfsal <- read_csv("data/project-data/2018-19_nba_player-salaries.csv")
View(dfsal)

## 18-19Player Stats
df_ind_stats <- read_csv("data/project-data/2018-19_nba_player-statistics.csv")
View(df_ind_stats)

## 18-19 Stats 1
df1819Stats1 <- read_csv("data/project-data/2018-19_nba_team-statistics_1.csv")
View(df1819Stats1)

## 18-19 Stats 2
df1819Stats2 <- read_csv("data/project-data/2018-19_nba_team-statistics_2.csv")
View(df1819Stats2)

## 2019-20 Pay roll team
df1920Pay <- read_csv("data/project-data/2019-20_nba_team-payroll.csv")
View(df1920Pay)

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

## dealing with Patty Mills abbreviated name, change to Patrick Mills as per salary file
df_ind_stats[df_ind_stats$player_name=="Patty Mills", "player_name"] <- "Patrick Mills"
view(df_ind_stats)






data_NA <-data_full %>%
  filter(data_full, is.na(data_full$G))
  duplicated(data_full$player_name)

install.packages("flipTables")
library(flipTables)
  
data_full %>%
rownames(merged)[rownames(merged) == "Patty Mills"] = "Patrick Mills"

data_full %>%
rename("Patrick Mills" == "Patty Mills")

data_full %>%
  names(data_full$player_name)["Patty Mills"] <- "Patrick Mills"

row.names(data_full, data_full$player_name)["Patty Mills"] <- "Patrick Mills"

view(data_full)

?row.names
data_full <- data_full %>%
rownames(data_full)[rownames(data_full) == "Patrick Mills"] <- "Patty Mills"

str_replace()



data_NA <- data_full %>%
  filter(which(is.na(data_full)))

view(data_NA)
  
  
sum(is.na(data_full))
which(is.na(data_full), arr.ind = TRUE)

which(is.na(data_full)
## replace NA values in dfSal

sum(is.na(dfsall))
which(is.na(dfsal), arr.ind = TRUE)


## combine data sets using full join to retain everything 
data_full <- full_join(x = df_ind_stats, y = dfsal,
                       by = c("player_name"))
view(data_full)

data_full %>% 
  group_by(player_id) %>% 
  fill(data_full$player_id, data_full$salary) %>% 
  distinct()

sum(is.na(data_full))
which(is.na(data_full), arr.ind = TRUE)

duplicated(data_full)
rbind(data_full$player_name)

view(data_full)



## Right join Salary data?
df_ind_stats <- dfsal %>%
  select(player_name, salary, player_id) %>%
  right_join(df_ind_stats, by="player_name")

view(df_ind_stats)

## duplicates df_ind_stats
duplicated(df_ind_stats$player_name)

## aggregate to newdf

newdf <- df_ind_stats %>%
  select(player_name) %>%
  summarise(across(.rows = if_any == n-1))






## NA 1819Stats1
sum(is.na(df1819Stats1))
which(is.na(df1819Stats1), arr.ind = TRUE)

##replace NA with "0" in df1891Stats1
df1819Stats1 <- replace_na(df1819Stats1, list("X23" = 0,
                                              "X24" = 0,
                                              "X25" = 0))
sum(is.na(df1819Stats1))



## NA 1819Stats2
sum(is.na(df1819Stats2))
which(is.na(df1819Stats2), arr.ind = TRUE)

## Right join Salary data?
df_ind_stats <- dfsal %>%
  select(player_name, salary, player_id) %>%
  right_join(df_ind_stats, by="player_name")

view(df_ind_stats)

## duplicates df_ind_stats
duplicated(df_ind_stats$player_name)

## aggregate to newdf

newdf <- df_ind_stats %>%
  select(player_name) %>%
  summarise(across(.rows = if_any == n-1))

ungroup(newdf)
ungroup(df_ind_stats)

view(newdf)

?across

group_by()
newdf2 <- aggregate(df_ind_stats[,7:31], list(c(df_ind_stats$player_name:df_ind_stats$PTS)), mean)

df1819Sal <- df1819Sal %>%
  relocate(player_id, .after = player_name)
  relocate(salary, .after = player_id)
  
  view(df1819Sal)
  
  sum(is.na(df1819Sal)) 
  which(is.na(df1819Sal), arr.ind = TRUE)
  
  
df1819Sal %>%
  group_by(player_id) %>%
  summarise(across(c()))

## Right join Salary & Player_id by player_name
df1819Stats <- df1819Sal %>%
  select(player_name, salary, player_id) %>%
  right_join(df1819Stats, by="player_name")

view(df1819Stats)

## finding duplicates
df1819Stats %>%
  duplicated(df1819Stats$player_name)

df1819Stats %>%
  duplicated(df1819Stats$player_name) %>%
  unique(df1819Stats$player_name)



#Reorder coloumns
df1819Stats <- df1819Stats %>%
  relocate(salary, .before = player_name) %>%
  relocate(Pos, .after = salary) %>%
  relocate(Age, .before = player_name) %>%
  relocate(player_id, .before = player_name)
  
view(df1819Stats)

## newdf and aggregate duplicates and sum values
df1819Stats %>%
  group_by(player_id) %>%
df1819Stats <-  aggregate(df1819Stats[,7:31], list(df1819Stats$player_name), sum)

# Create newdf and aggregate from 1819Stats
newdf <- aggregate(df1819Stats[,7:31], list(df1819Stats$player_name), FUN = mean)
view(newdf)
df1819Stats$salary, df1819Stats$G)
df1819Stats$Age, df1819Stats$Pos, df1819Stats$Tm
# Right join salary, age, pos, player id

names(Group.1 = player_name)

newdf%>%
newdf <- df1819Sal %>%
  select(player_id, salary) %>%
  left_join(df1819Sal, by= df1819Sal$player_name)
view(newdf)

newdf <- aggregate(df[,2:3], list(df$name), sd )

which(duplicated(newdf$player_name), arr.ind = TRUE)

view(newdf)

duplicated(newdf$Group.1)
duplicated(newdf$Group.2)
unique(newdf$Group.1, newdf$Group.2)
str(newdf)

## rename newdf Group.1 as player_name
names(df_joined)[13] <- "X3P"
names(df_joined)[14] <- "X3PA"
names(df_joined)[16] <- "X2P"
names(df_joined)[17] <- "X2PA"

view(df_joined)

## right join player positions
newdf <- df1819Stats %>%
  select(player_name, Pos, Age) %>%
  right_join(newdf, by="player_name")

view(newdf)

newdf %>%
  summary(newdf$Pos_factor)

##assign factor to Pos
newdf <- newdf %>%
  mutate(Pos_factor = "")
  newdf$Pos_factor <- as.factor(newdf$Pos)

newdf <- newdf %>%  
  relocate(Pos_factor, .before = Pos)

## duplicates in salary
df1819Sal %>%
  duplicated(df1819Sal$player_name)

## right join from salary 
newdf <- df1819Sal %>%
  select(player_name, salary, player_id) %>%
  right_join(newdf, by="player_name")

view(newdf)

sum(is.na(newdf))
which(is.na(newdf), arr.ind = TRUE)

newdf <- newdf %>%
  filter(!is.na(newdf$salary))

str(newdf)

## reorder salaries and player_id
newdf <- newdf %>%
  relocate(player_id, .before = player_name)

view(newdf)

## duplicates newdf
newdf %>%
  duplicated(newdf$player_name)
  unique(newdf$player_name)

newdf <- newdf %>%
    group_by(player_name) %>%
  
newdf <- aggregate(newdf[,6:30], list(newdf$player_name), sum)
  
view(newdf)

## relocate salaries and POS and Age
newdf <- newdf %>%
  relocate(salary, .before = player_name)
newdf <- newdf %>%
  relocate(Pos, .after = salary)
newdf <- newdf %>%
  relocate(Age, .before = player_name)

view(newdf)

##assign factor to Pos
newdf <- newdf %>%
  mutate(Pos_factor = "")
newdf$Pos_factor <- as.factor(newdf$Pos)
df_ind_stats <- as.factor(df_ind_stats$Pos)
str(df_ind_stats$Pos)

view(df_ind_stats)



### group and summarise data


## Find NA values and convert to "."
replace(df_ind_stats, is.na(df_ind_stats), paste("."))

replace(data_full, is.na(data_full), ".")

replace_na(data_full, replace("unknown"))

data_full <- datafull %>%
  as.numeric(data_full$salary)

view(data_full)

data_full <- data_full %>%
  group_by(data_full$player_id, data_full$Age) %>%
  coalesce(data_full$player_id, data_full$salary)

view(df_ind_stats)

sum(is.na(data_full$player_id))
which(is.na(data_full$player_id), arr.ind = TRUE)

data_na <- data_full %>%
  filter(c(38, 53, 194, 250, 269, 297, 396, 415, 416, 417, 441, 464, 471, 551, 558, 579, 606, 614, 615, 616,
           667, 682))

data_full[is.na(data_full)] = "NA"

## NA
data_full %>%
  sum(is.na(data_full))
which(is.na(data_full), arr.ind = TRUE)
filter(data_full, is.na(data_full$salary))

##replace salary NA with "Unknown"
data_full <- replace_na(data_full, list(salary = "unknown"))
sum(is.na(data_full))

view(data_full)


## player_id NA's
## NA
data_full %>%
  sum(is.na(data_full))
which(is.na(data_full), arr.ind = TRUE)
filter(data_full, is.na(data_full$player_id))

##replace NA with "Final"
data_full <- replace_na(data_full, list(player_id = "unknown"))
sum(is.na(data_full))

view(data_full)


###


data_na <- data_full %>%
  filter(data_full$salary == "unknown")
data_na
view(data_na)




###

data_full %>%
  fill_gaps(salary = unknown)



## relocate salaries and POS and Age
newdf <- newdf %>%
  relocate(salary, .before = player_name)
newdf <- newdf %>%
  relocate(Pos, .after = salary)
newdf <- newdf %>%
  relocate(Age, .before = player_name)

view(newdf)


##assign factor to Pos
newdf <- newdf %>%
  mutate(Pos_factor = "")
newdf$Pos_factor <- as.factor(newdf$Pos)
df_ind_stats <- as.factor(df_ind_stats$Pos)
str(df_ind_stats$Pos)

view(df_ind_stats)



### group and summarise data


## Find NA values and convert to "."
replace(df_ind_stats, is.na(df_ind_stats), paste("."))

replace(data_full, is.na(data_full), ".")

replace_na(data_full, replace("unknown"))

data_full <- datafull %>%
  as.numeric(data_full$salary)

view(data_full)

data_full <- data_full %>%
  group_by(data_full$player_id, data_full$Age) %>%
  coalesce(data_full$player_id, data_full$salary)

view(df_ind_stats)

sum(is.na(data_full$player_id))
which(is.na(data_full$player_id), arr.ind = TRUE)

data_na <- data_full %>%
  filter(c(38, 53, 194, 250, 269, 297, 396, 415, 416, 417, 441, 464, 471, 551, 558, 579, 606, 614, 615, 616,
           667, 682))

data_full[is.na(data_full)] = "NA"

## NA
data_full %>%
  sum(is.na(data_full))
which(is.na(data_full), arr.ind = TRUE)
filter(data_full, is.na(data_full$salary))

##replace salary NA with "Unknown"
data_full <- replace_na(data_full, list(salary = "unknown"))
sum(is.na(data_full))

view(data_full)


## player_id NA's
## NA
data_full %>%
  sum(is.na(data_full))
which(is.na(data_full), arr.ind = TRUE)
filter(data_full, is.na(data_full$player_id))

##replace NA with "Final"
data_full <- replace_na(data_full, list(player_id = "unknown"))
sum(is.na(data_full))

view(data_full)


###


data_na <- data_full %>%
  filter(data_full$salary == "unknown")
data_na
view(data_na)




###

data_full %>%
  fill_gaps(salary = unknown)



## relocate salaries and POS and Age
newdf <- newdf %>%
  relocate(salary, .before = player_name)
newdf <- newdf %>%
  relocate(Pos, .after = salary)
newdf <- newdf %>%
  relocate(Age, .before = player_name)

view(newdf)



