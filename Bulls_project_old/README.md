----
# Reproducible data analysis:
##  Chicago Bulls Project: Player Analysis and Recomendations.
**u125511**
<br/>

### Introduction  
***
This GitHub repo comprises of all the components for a reproducible data analysis project, which was initially created as part of the Data Analysis in Sport course at the University of Canberra.  

***
##### Background
***
This project is based around the "Moneyball" theory of using statistical analysis to provide a greater insight into sport performances, in this case the selection/purchase of players from the 2018-19 season of the NBA who would help produce greater results for the Chicago Bulls organisation to improve on their past season result (finishing 13th in the Eastern Conference, and 27th overall on Win-Loss ratio) and provide an improved result for the upcoming 2019-2020 NBA season.  
  
The assigned task included the following:  

  * The assessment of potential players to purchase or retain for the Chicago Bulls organisation for the 2019-20 NBA season.  
  * Projection of expected results with selected players.    
  * Selection of 5 players, one from each position (Center, Power Forward, Small Forward, Shooting Guard, Point Guard).  
  * Ensure purchase of the 5 players was within the allotted budget of $118 million dollars.  
  * The proposed purchases must allow enough budget to still field the other remaining players required for an NBA team (NBA teams are allowed 15 players total).  
  
The use of statistics in sport is not a new phenomenon, partly due to people like Bill James and John Hollinger who implemented and revolutionised the use of statistical analysis, and is now common within sports like basketball and in particular the North American basketball league the NBA. John Hollinger created the all in one metric the Player Efficiency Rating or PER, which allowed for the collection of several variables (i.e both positive and negative outcomes e.g turnovers/)

The hypothesis for this project is based on the use of a combination of known analysis methods to create a predictive equation to aid in the selection of appropriate players for the Chicago Bulls 19/20 season in the NBA. 

The variables were used to show an association of an increase in overall Win% due to an increase of points per minute played. The variables used for the predictive value were:  

  * Effective Field Goal Percentage (eFGp)  
  * Trade Value (TrV)  
  * Efficiency rate (EFF)  
  * Usage Rate (Tm_use)  
  * Total Rebounds per minute (TRB_MP)  
  * Points per minute (PTS_per_MP)  
<br> 

I believe that using a multifaceted approach to the analysis of player performance decreases the disparity between observed results and predictive results.

This project highlighted several trends within the NBA data and the NBA overall standings results. This mode of retrospective/prospective analysis still relies on the game based execution of set actions/reactions. This can be seen within the confidence intervals within each predictive variable, showing the margin for difference between expected and observed.

The purpose and problem that this method of analysis provides is a way to see through the inflated market values for athletes and highlight the true value of players based on their repeated trends.I believe that the predictive formula of:  
  
**Points per minute**
$$
\beta_1 = -0.382 + 0.699 * eFGp + -0.0330 * TRB_MP + 2.39 * Tm_use_total + 0.00000965 * EFF + -0.00000803 * TrV
$$

I hope you enjoy this project as much as I did. Although challenging in the initial cleaning/set up/modeling, it is engaging when looking through final product and to see the results.
<br/>  
<br/>  

#### Credits: 
**Dr. Jocelyn Mara:** Data Analysis in Sport PG, University of Canberra, 2021   
**Martin Manley:** Kansas City sports reporter and statistician, EFF calculation.    
**Bill James:** Statistician, Trade Value calculation, Approximate Value calculation, Credits Calculation.  
**John Hollinger:** Effective Field Goal percentage and Usage Rate calculation  
**Dean Oliver:** Effective Field Goal percentage and Usage Rate calculation  
[**Basketball-reference.com**](https://www.basketball-reference.com/)
<br>
<br>

***
### How to use this project:  
***
This project was designed and built through RStudio, Version 1.4.1103, © 2009-2021 RStudio, PBC  
<br>

##### This Readme file and GitHub repo covers the following:
***
  * Data sources
    * Raw data
  * File locations
  * Operational order
  * Tidy data/created *.csv files
  * Glossary of definitions and abbreviations used for each data base
  * Relevant calculations
  
##### Data sources

1. [2018-19_nba_player-statistics.csv](https://www.basketball-reference.com/leagues/NBA_2019_totals.html)  

2. [2018-19_nba_player-salaries.csv](https://hoopshype.com/salaries/)  

3. [2019-20_nba_team-payroll.csv](https://hoopshype.com/salaries/)  

4. [2018-19_nba_team-statistics_1.csv](https://www.basketball-reference.com/leagues/NBA_2019.html)  

5. [2018-19_nba_team-statistics_2.csv](https://www.basketball-reference.com/leagues/NBA_2019.html)  
<br>

##### File Locations
Located within the Chicago_Bulls_u125511 folder 

  * Rmarkdown -> Chicago_Bulls_u125511
  * Data:
    * Project-data
    * Tidy_data
  * Funcs -> Rscript files (in descending operational order)  
    * Bulls_Fresh_start.R  
    * Teams_wins_loss_df.R  
    * Exploratory_Analysis_2.R  
    * Bulls_multi_reg.R  
  * Figures 
  * Images  
  * Funcs  
  * References  

##### Operational order: 

Scripts to be loaded and run through Rstudio program:  

  1. Bulls_Project_Fresh_start.R  
  2. Team_wins_loss_df.R  
  3. Explortory_Analysis_2.R  
  4. Bulls_Multi_reg R  
  
##### Tidy data/created *.csv files
The following *.csv files will be exported locally into the data/tidy_data folder: 

  * player_stats_tidy.csv  
  * df_team_Stats1.csv  
  * df_team_Stats2.csv  
  * df_TOT_players.csv  
  * df_nonTOT_clean.csv  
  * datC.csv  
  * datPF.csv  
  * datPG.csv  
  * datSF.csv  
  * datSG.csv  

*** 
#### Relevant calculations
***


* Effective Field Goal Percentage (eFGp)
* Trade Value (TrV)
* Efficiency rate (EFF)
* Usage Rate (Tm_use)


**Usage rate equation** (TM_use_total)

  * **[Usage Rate](https://www.nbastuffer.com/analytics101/usage-rate/)** is a calculation of the percentage a player is used by the team.
  
It is calculated by:   
$$
100*((FGA+0.44*FTA+TO)*(TMP/5))/(MP*(TFGA+0.44*TFTA+TTO))
$$
  
**Effective field goal percentage** (eFGp)

  * **[Effective Field Goal Percentage (eFGp)](https://www.basketball-reference.com/about/glossary.html#:~:text=eFG%25%20%2D%20Effective%20Field%20Goal%20Percentage,for%2010%20with%200%20threes.)** A statistic that adjusts field goal percentage to account for the fact that three-point field goals count for three points while field goals only count for two points.  

It is calculated by: 
$$
eFG(\%) =\frac{FG+(0.5*3P)}{FGA}
$$

```{r pressure, echo=FALSE, fig.cap="eDG% calculation", out.width = '100%'}
knitr::include_graphics("CodeCogsEqn.gif")
```
`\begin{equation}\\ 
  eFG(%)\left = \frac{FG+(0.5*3P)}/{FGA}
\end{equation}`

`<a href="https://www.codecogs.com/eqnedit.php?latex=\dpi{150}&space;\bg_black&space;\LARGE&space;eFG%&space;=&space;(FG&plus;(0.5*3P))/FGA" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\dpi{150}&space;\bg_black&space;\LARGE&space;eFG%&space;=&space;(FG&plus;(0.5*3P))/FGA" title="\LARGE eFG% = (FG+(0.5*3P))/FGA" /></a>`

 `$$eFG(%) = \{FG+(0.5*3P)}/{FGA}$$`

**Trade Value**

  * **[Trade Value](https://www.nbastuffer.com/analytics101/trade-value/)** is the estimate using a player’s age and his approximate value to determine how much value a player has left in his career. Invented by Bill James.
  
It is calculated by: 
$$
Trade Value Formula=[(Approximate Value- 27-0.75*Age)2(27-0.75*Age +1)*Approximate Value]/190+(Approximate Value)*2/13
$$

  * **Approximate Value**
  
    * **[Credit Formula and Approx Value](https://www.nbastuffer.com/analytics101/approximate-value/)** is the metric which is an estimate of a player’s value, making no fine distinctions, but, rather, distinguishing easily between very good seasons, average seasons, and poor seasons.

It is calculated by:  
$$
AV Formula = (Credits(3/4) )/21
$$

  * **Credits Formula** 

    * **[Credit Formula and Approx Value](https://www.nbastuffer.com/analytics101/approximate-value/)** is an aggregation of observations from a standard game/season, in combination used within the approximate value calculation.

It is calculated by:   
$$
Credits Formula = (Points)+(Rebounds)+(Assists)+(Steal)+(Blocks)-(Field Goals Missed)-(Free Throws Missed)-(Turnovers)
$$

**Efficiency Value** 

  * **[Efficiency Value](https://www.nbastuffer.com/analytics101/nba-efficiency/)**, is a metric invented by Martin Manley, is being considered the first ever player evaluation metric which indicates player’s linear efficiency.

It is calculated by: 
$$
EFF = (PTS + REB + AST + STL + BLK − Missed FG − Missed FT - TO) / GP 
$$

***
#### Glossary:
***

**NBA standard terms:**  

  *  [Glossary of NBA Statistics](https://www.basketball-reference.com/about/glossary.html)   
  *  [Basteball Positions](https://en.wikipedia.org/wiki/Basketball_positions)  

**Project specific:** 

  * Pos = Position  
  * Tm = Team, abbreviated to three letters, i.e Chicago = CHI, Houston = HOU etc.  
  * '..._MP' = Statistic at a per minute rate  
  * 'TM_...' = Statistic as a team total  
  * Tm_use_total = Total use by the team as a percentage across the total number of minutes played  

**Data frame specific**  

[2018-19_nba_player-statistics.csv](https://www.basketball-reference.com/leagues/NBA_2019_totals.html)  

This data file provides total statistics for individual NBA players during the 2018-19 season.  
The variables consist:  

  * player_name : Player Name
  * Pos :  (PG = point guard, SG = shooting guard, SF = small forward, PF = power forward, C = center) 
  * Age : Age of Player at the start of February 1st of that season.
  * Tm : Team
  * G : Games
  * GS : Games Started
  * MP : Minutes Played
  * FG : Field Goals
  * FGA : Field Goal Attempts
  * FG% : Field Goal Percentage
  * 3P : 3-Point Field Goals
  * 3PA : 3-Point Field Goal Attempts
  * 3P% : FG% on 3-Pt FGAs
  * 2P : 2-Point Field Goals
  * 2PA : 2-point Field Goal Attempts
  * 2P% : FG% on 2-Pt FGAs
  * eFG% : Effective Field Goal Percentage
  * FT : Free Throws
  * FTA : Free Throw Attempts
  * FT% : Free Throw Percentage
  * ORB : Offensive Rebounds
  * DRB : Defensive Rebounds
  * TRB : Total Rebounds
  * AST : Assists
  * STL : Steals
  * BLK : Blocks
  * TOV : Turnovers
  * PF : Personal Fouls
  * PTS : Points  
  <br>
    * NB: Players that were traded during the season may appear more than once (on more than one row) so it is important to handle these duplications appropriately.
<br>

[2018-19_nba_player-salaries.csv](https://hoopshype.com/salaries/)  

This data file contains the salary for individual players during the 2018-19 NBA season.   
The variables consist:  

  * player_id : unique player identification number
  * player_name : player name
  * salary : year salary in $USD
<br>

[2019-20_nba_team-payroll.csv](https://hoopshype.com/salaries/)  

This data file contains the team payroll budget for the 2019-20 NBA season.  
The variables consist:  

  * team_id : unique team identification number
  * team : team name
  * salary : team payroll budget in 2019-20 in $USD
<br>

[2018-19_nba_team-statistics_1.csv](https://www.basketball-reference.com/leagues/NBA_2019.html)  

This data file contains miscellaneous team statistics for the 2018-19 season. 

  The variables consist:  

  * Rk : Rank
  * Age : Mean Age of Player at the start of February 1st of that season.
  * W : Wins
  * L : Losses
  * PW : Pythagorean wins, i.e., expected wins based on points scored and allowed
  * PL : Pythagorean losses, i.e., expected losses based on points scored and allowed
  * MOV : Margin of Victory
  * SOS : Strength of Schedule; a rating of strength of schedule. The rating is denominated in points above/below average, where zero is average.
  * SRS : Simple Rating System; a team rating that takes into account average point differential and strength of * schedule. The rating is denominated in points above/below average, where zero is average.
  * ORtg : Offensive Rating; An estimate of points produced (players) or scored (teams) per 100 possessions
  * DRtg : Defensive Rating; An estimate of points allowed per 100 possessions
  * NRtg : Net Rating; an estimate of point differential per 100 possessions.
  * Pace : Pace Factor: An estimate of possessions per 48 minutes
  * FTr : Free Throw Attempt Rate; Number of FT Attempts Per FG Attempt
  * 3PAr : 3-Point Attempt Rate; Percentage of FG Attempts from 3-Point Range
  * TS% : True Shooting Percentage; A measure of shooting efficiency that takes into account 2-point field goals, 3-point field goals, and free throws.
* eFG% : Effective Field Goal Percentage; This statistic adjusts for the fact that a 3-point field goal is worth one more point than a 2-point field goal.
* TOV% : Turnover Percentage; An estimate of turnovers committed per 100 plays.
* ORB% : Offensive Rebound Percentage; An estimate of the percentage of available offensive rebounds a player grabbed while he was on the floor.
* FT/FGA : Free Throws Per Field Goal Attempt
* DRB% : Defensive Rebound Percentage
<br>

[2018-19_nba_team-statistics_2.csv](https://www.basketball-reference.com/leagues/NBA_2019.html)  

This data file contains total team statistics for the 2018-19 NBA season.  

The variables consist:  

  * Team : Team name  
  * Rk : Ranking  
  * MP : Minutes Played  
  * G : Games  
  * FG : Field Goals  
  * FGA : Field Goal Attempts  
  * FG% : Field Goal Percentage  
  * 3P : 3-Point Field Goals  
  * 3PA : 3-Point Field Goal Attempts  
  * 3P% : FG% on 3-Pt FGAs  
  * 2P : 2-Point Field Goals  
  * 2PA : 2-point Field Goal Attempts  
  * 2P% : FG% on 2-Pt FGAs  
  * FT : Free Throws  
  * FTA : Free Throw Attempts  
  * FT% : Free Throw Percentage  
  * ORB : Offensive Rebounds  
  * DRB : Defensive Rebounds  
  * TRB : Total Rebounds  
  * AST : Assists  
  * STL : Steals  
  * BLK : Blocks  
  * TOV : Turnovers  
  * PF : Personal Fouls 
  * PTS : Points  
<br/>
   
