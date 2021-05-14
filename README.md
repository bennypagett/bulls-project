# Bulls Project: Player Analysis and Recomendations.
### u125511


# Introduction

# This Readme covers the following:

  * File locations
  * Data sources
  * Variable definitions from respective data sources
  * Relevant calculations
  *

Table Header  | Second Header
------------- | -------------
Table Cell    | Cell 2
Cell 3        | Cell 4

## Data sources

1. [NBA 2018-19 Season Stats](https://www.basketball-reference.com/leagues/NBA_2019_totals.html)

2. [Basteball Positions](https://en.wikipedia.org/wiki/Basketball_positions)

3. [Glossary of NBA Statistics](https://www.basketball-reference.com/about/glossary.html)



What was your motivation?
Why did you build this project?
What problem does it solve?
What did you learn?
What makes your project stand out? If your project has a lot of features, consider adding a "Features" section and listing them here.

* Include credits:

Dr. Jocelyn Mara, University of Canberra

How to Use your Project

Provide instructions and examples so users/contributors can use the project. This will make it easy for them in case they encounter a problem – they will always have a place of reference.

You can also include screenshots to show examples of the running project.

1. Fresh start Bulls R.script
2. Teams Wins Loss
3. Explortory Simple linear regression
4. Bulls Multi reg



Overview
Congratulations! This is the first step in your journey towards a career in full-stack web development. There are many paths that you can take in this field and this unit is the foundation for all of them. Every full-stack web developer must master HTML and CSS, as well as learn how to program browsers, servers, and databases.

You have several choices for the programming language that you use for building and deploying full-stack web applications, including JavaScript, PHP, and Python. This course focuses on JavaScript. We’ll use it to program both the browser (aka the client) and the server.

Regardless of the programming language you use, two tools that every developer uses on a daily basis are the command line and version control. The command line allows developers to quickly and efficiently interface with their operating system and software. To begin, we'll use the command line to navigate the file tree and create directories and files. Later, we'll use it to install software dependencies and run servers, among other tasks. Version control is an approach to managing changes in files without the need to make multiple copies of those files. We'll learn Git, which is the most popular version control system. Git integrates with GitHub.com, a site for developers to host and share their code. We will deploy our first website using GitHub Pages.

The first, and perhaps most important, file we'll create is index.html, which is the default entry point for any web application. All of our subsequent work will build on this initial starting point. The file suffix .html refers to HTML, or Hypertext Markup Language. HTML allows us to format webpages and text in a similar way to how a word processor formats documents and the text inside them. However, the biggest difference between HTML and a word processor is the ability to link between any document that's on the web, anywhere in the world. This is the "hypertext" in HTML.

Though HTML is enough to create a simple website, it falls a bit short in the design department. So we'll add color, fonts, and element positioning by adding CSS (Cascading Style Sheets) to our HTML files to make them visually dynamic. In the next unit, we'll learn CSS frameworks that can expedite our development process.

Subsequent units will build on this foundation of HTML, CSS, and version control as we add JavaScript, servers, and databases to our stack to build interactive web applications.

Key Topics
The following topics will be covered in this unit:

Command-line basics
Navigating the file tree
Creating, copying, and removing files and directories
HTML
Semantic elements, tags
Attributes
Best practices: indentation, file naming conventions and directory structure
CSS
Order of importance
Class vs. id
Selectors
Typography
Box model
Positioning and floats
Color: hexadecimal, rgb and named
Git & Git workflow
git clone
git add
git commit
git push
git pull
GitHub
Create a repository
Deploy to personal pages
Comprehension Check
You will be employer-ready if you can answer the following questions:

What does it mean to be a full-stack web developer?
What is the relationship between HTML and CSS?
What is Git workflow?
Learning Objectives
You will be employer-competitive if you are able to:

Build and style static webpages with semantic HTML and CSS
Implement best practices and standards when structuring HTML files using nested elements, indentation, comments, and line breaks
Implement CSS styling via class, id and element selectors using external stylesheets, inline styles and embedded style tags
Explain the "cascading" in Cascading Style Sheets and implement the box model for HTML elements
Explain the value of version control and use Git workflow to initialize projects, track changes, and host via remote server
Perform common commands via the command line to interface with the operating system, such as navigating the file tree and creating and deleting files and directories
Execute live deployment using GitHub Pages
Homework: Code Refactor
Take the provided codebase and refactor it to make it accessible. Don't forget the cardinal rule when working with someone elses code: "Always leave the code you are editing a little cleaner than you found it"

Helpful Links
Version Control
HTML
CSS
Pro Git
Dev Docs



### <span style="color: blue;">The following is information required for the Chicago Bulls player analysis and report.</span>


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
`\begin{equation}\\ 
  eFG(%)\left = \frac{FG+(0.5*3P)}/{FGA}
\end{equation}`

<a href="https://www.codecogs.com/eqnedit.php?latex=\dpi{150}&space;\bg_black&space;\LARGE&space;eFG%&space;=&space;(FG&plus;(0.5*3P))/FGA" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\dpi{150}&space;\bg_black&space;\LARGE&space;eFG%&space;=&space;(FG&plus;(0.5*3P))/FGA" title="\LARGE eFG% = (FG+(0.5*3P))/FGA" /></a>

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