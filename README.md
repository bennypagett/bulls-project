# Bulls Project: Player Analysis and Recomendations.
### u125511

### <span style="color: blue;">The following is information required for the Chicago Bulls player analysis and report.</span>
* This file covers the following:
  * Variable definitions from respective data sources
  * Data sources
  * Relevant calculations, 

`r colorize("some words in red", "red")
<span style="color: red;">>text</span>

## Observations defitions:

# 2018-19_nba_player-statistics.csv  
This data file provides total statistics for individual NBA players during the 2018-19 season. The variables consist:

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
* NB: Players that were traded during the season may appear more than once (on more than one row) so it is important to handle these duplications appropriately.

 

# 2018-19_nba_player-salaries.csv 
This data file contains the salary for individual players during the 2018-19 NBA season. The variables consist:

* player_id : unique player identification number
* player_name : player name
* salary : year salary in $USD
 

# 2018-19_nba_team-payroll.csv 
This data file contains the team payroll budget for the 2019-20 NBA season. The variables consist:

* team_id : unique team identification number
* team : team name
* salary : team payroll budget in 2019-20 in $USD
 

# 2018-19_nba_team-statistics_1.csv 
This data file contains miscellaneous team statistics for the 2018-19 season. The variables consist:

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
 

# 2018-19_nba_team-statistics_2.csv 
This data file contains total team statistics for the 2018-19 NBA season. The variables consist:

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

## Effective field goal percentage
From Wikipedia, the free encyclopedia
Jump to navigationJump to search
In basketball, effective field goal percentage (abbreviated eFG%) is a statistic that adjusts field goal percentage to account for the fact that three-point field goals count for three points while field goals only count for two points. [1] Its goal is to show what field goal percentage a two-point shooter would have to shoot at to match the output of a player who also shoots three-pointers. [2]

It is calculated by: 
$$
eFG(\%) =\frac{FG+(0.5*3P)}{FGA}
$$

```{r pressure, echo=FALSE, fig.cap="eDG% calculation", out.width = '100%'}
knitr::include_graphics("CodeCogsEqn.gif")
```
`\begin{equation} 
  eFG(%)\left = \frac{FG+(0.5*3P)}{FGA}
  (\#eq:frac)
\end{equation}`

<a href="https://www.codecogs.com/eqnedit.php?latex=eFG%&space;=&space;(FG&plus;(0.5*3P))/FGA" target="_blank"><img src="https://latex.codecogs.com/gif.latex?eFG%&space;=&space;(FG&plus;(0.5*3P))/FGA" title="eFG% = (FG+(0.5*3P))/FGA" /></a>

 `$$eFG(%) = \{FG+(0.5*3P)}/{FGA}$$`

where:

FG = field goals made
3P = 3-point field goals made,
FGA = field goal attempts,
[3]


A rough approximation can also be had by: 
$$
eFG(\%) =\frac{\frac{PPG-FT}{2}}{FGA}
$$

where:

PPG = points per game
FT = the free throws made
FGA = field goal attempts
The advantage of this second formula is that it highlights the aforementioned logic behind the statistic, where it is pretended that a player only shot two-point shots (hence the division of non-free-throw points by 2).


An additional formula that seems to be more in use by the statistics actually displayed on websites (but less cited by said websites) is:


$$
eFG(\%) =\frac{2FG + (1.5*3FG)}{FGA}
$$

where:

2FG = 2-point field goals made
3FG = 3-point field goals made
FGA = field goal attempts