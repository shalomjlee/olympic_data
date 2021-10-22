# Olympic Athlete Data Analysis
**_Created by [Maria Dong](https://github.com/mariajdong), [Jess Izumi](https://github.com/jess-izuu), & [Shalom Lee](https://github.com/shalomjlee)._**

An [R Shiny dashboard](https://rstudio.github.io/shinydashboard/) that analyzes Olympic athlete data from 1896 to 2016. Attributes analyzed include age, sex, team, year/season of games, medals, and more.

<br>

![screenshot1](/images/screenshot1.png)
_Figure 1: A screenshot of the dashboard landing page._

## Background
The [Olympic Games](https://en.wikipedia.org/wiki/Olympic_Games) are the most prominent and celebrated series of international sporting events, in which athletes around the world compete. We wanted to further explore data around these athletes, dating back to 1896, when the first modern Olympics was held.

## Getting Started
*To view the dashboard, you must download the Open Source Edition of [R Studio](https://www.rstudio.com/products/rstudio/), available for free [here](https://www.rstudio.com/products/rstudio/).*

1. Download the repo in your preferred manner.
2. Open `olympic_dash.R` in R Studio.
3. Click `Run App` at the top right-hand corner of the file display.

![screenshot2](/images/screenshot2.png)

4. Once the dashboard window opens, maximize the window for optimal viewing.

## Resources, Libraries, & Tools
**Data Sources**
* [Kaggle](https://www.kaggle.com/mysarahmadbhat/120-years-of-olympic-history) for Olympic athlete data
* [Getty Images](https://www.gettyimages.com/) for landing page pictures
* [Google Fonts](https://fonts.google.com/) for custom fonts

**Libraries**
* [R Shiny](https://shiny.rstudio.com/) and [Shiny Dashboard](https://rstudio.github.io/shinydashboard/) to build an interactive web application in a dashboard format
* [Tidyverse](https://www.tidyverse.org/) for data manipulation and cleaning
* [Treemapify](https://cran.r-project.org/web/packages/treemapify/vignettes/introduction-to-treemapify.html) for treemap plotting
* [Fresh](https://github.com/dreamRs/fresh) for dashboard formatting

**Tools & languages**: R, HTML, CSS, [R Studio](https://www.rstudio.com/products/rstudio/)

## Features
After launching the dashboard, you should see a homepage featuring pictures and fun facts about the Olympics and its history.

<br>

The next tab, titled *Athlete Demographics by Team*, explores athlete demographic variables by country selected.

![country_input](/images/t2input.png)
_Figure 2: An interactive dropdown menu that changes all graphics on the tab._

![age_hist](/images/t2v2.png)
_Figure 3: An example of a visualization on this tab. More interactivity may be offered for specific visualizations, as with the radio buttons pictured in the top right._

<br>

Finally, the last tab, titled *Events, Medals, & Trends*, delves more into Olympic medals and events. First, the user needs to select an Olympic year and season.

![medal_input](/images/t3input.png)
_Figure 4: A slider and radio buttons for user input._ 

The visuals will respond if applicable, and may offer more interactivity, as before.

![medal_scatter](/images/t3v1.png)
_Figure 5: An example of a visualization on this tab. A scatter plot and trendline visualizing correlation between number of athletes and medals won for a specific year's Olympic Games. Users can draw a box around points of interest in the plot, and additional information about those points will populate in the box to the right._

## Analyses & Discussion
### Demographic Findings
**Height vs. weight scatter plot:**
* Predictably, male athletes tend to be taller and heavier than females.
* The trendline of males is also steeper for all countries, showing that males are heavier per unit of height than females are. 
* For most countries, medalists' heights and weights are more condensed, suggesting that points furthest from the trendline are less likely to have won a medal.

**Distribution of age by gender:**
* For most countries, the mean age of athletes has shifted upwards from "before 1990" to "1990 and after". Interestingly, two major countries that do not seem to have followed this trend are Russia and China.
* All countries have increased their numbers of female athletes in "1990 and after" as opposed to "before 1990".
* Female athletes tend to form the majority of the youngest athletes, whereas males tend to form the majority of the oldest athletes.

**Number of athletes over time:**
* Most countries have increased their number of Olympic athletes per game over time.
* Upward "spikes" in athlete numbers are often seen for host countries. See:
  * Brazil in Summer 2016, 
  * Russia in Winter 2014, 
  * the UK in Summer 2012, 
  * China in Summer 2008, 
  * and Italy in Winter 2006.
* Again, the later rise in numbers of female athletes can be seen, but with more detail with regards to time.

### Findings on Medals and Events
**Number of athletes vs. number of medals scatter plot:**
* The two variables are positively correlated for all years of Olympic Games.
* The USA is consistently at/near the top of the trendline, showing that they usually have one of the highest number of athletes and medals for that year's games.

**Olympic events for selected year/season:**
* Over time, the number of events and categories of events have proliferated greatly.
* There are significantly more Summer events than there are Winter.
* "Athletics" has always been the largest category for the Summer Olympics.

**Count of medals per country over time:**
* The USA has consistently been a top earner of medals.
* The "spike" (as discussed previously in the demographics section) can again be seen with some host countries and number of medals won that year.
  * This is consistent with our previous finding that more athletes are correlated with more medals, and that host countries were likely to send more athletes than usual to the games they hosted.

## Future Considerations
Some things we'd like to work on in future edits:

**Bugs:**
* Fixing the appearance of graphs when there are no applicable athletes
* Fixing the slider for year on the "Events, Medals, & Trends" tab, so that it will automatically adjust to an existing year of games for the selected season

**Appearance:**
* Creating a more visually appealing layout
* Adjusting color scales for some visuals, namely the treemap